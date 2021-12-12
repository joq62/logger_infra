%% Author: joqerlang
%% Created: 2021-11-18 
%% Connect/keep connections to other nodes
%% clean up of computer (removes all applications but keeps log file
%% git loads or remove an application ,loadand start application
%%  
%% Starts either as controller or worker node, given in application env 
%% Controller:
%%   git clone and starts 
%% 
%% Description: TODO: Add description to application_org
%% 
-module(lib_logger_infra).
 
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Behavioural exports
%% --------------------------------------------------------------------
-export([
	 store/1,
	 read_all/0,
	 read_all/1
        ]).

%% --------------------------------------------------------------------
%% Internal exports
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Macros
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Records
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% API Functions
%% --------------------------------------------------------------------

%% ====================================================================!
%% External functions
%% ====================================================================!
%% --------------------------------------------------------------------
%% Func: start/2
%% Returns: {ok, Pid}        |
%%          {ok, Pid, State} |
%%          {error, Reason}
%%---------------------------------------------------------------------
store(Info)->
    [N|_]=sd:get(dbase_infra),
    ok=rpc:call(N,db_logger,create,[Info],5*1000),
    ok.

read_all()->
    [N|_]=sd:get(dbase_infra),
    Info=rpc:call(N,mnesia,dirty_all_keys,[logger_info],5*1000),
    SortedList=lists:reverse(lists:sort(Info)),
    [rpc:call(N,db_logger,nice_print,[Id],3*1000)||Id<-SortedList],
    ok.
read_all(NumLatesInfo)->
    [N|_]=sd:get(dbase_infra),
    Info=rpc:call(N,mnesia,dirty_all_keys,[logger_info],5*1000),
    SortedList=lists:reverse(lists:sort(Info)),
    [rpc:call(N,db_logger,nice_print,[Id],3*1000)||Id<-lists:sublist(SortedList,NumLatesInfo)],
    ok.
