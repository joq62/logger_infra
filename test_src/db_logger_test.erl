%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description :  1
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(db_logger_test).   
      
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("kernel/include/logger.hrl").
-include("controller.hrl").
-include("logger_infra.hrl").
%% --------------------------------------------------------------------

%% External exports
-export([start/0]). 


%% ====================================================================
%% External functions
%% ====================================================================


%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
%create(DateTime,Node,Severity,Msg,M,F,L,A)

start()->
 %   ok=db_logger:create_table(),
   % init 
    
    L1=?logger_info(alert,"test1",[]),
    L2=?logger_info(alert,"test2",[23,76]),
    L3=?logger_info(ticket,"test3",[]),
    L4=?logger_info(info,"server started",[]),

    ok=logger_infra:log(L1),
    ok=logger_infra:log(L2),
    ok=logger_infra:log(L3),
    ok=logger_infra:log(L4),

    logger_infra:read_all(),
    io:format(" next ~n"),
    logger_infra:read_all(2),
    

    
    
   
    ok. 

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

logger_all()->
    
    A=[],
    lists:keysort(1,A).
