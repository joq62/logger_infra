%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : resource discovery accroding to OPT in Action 
%%% This service discovery is adapted to 
%%% Type = application 
%%% Instance ={ip_addr,{IP_addr,Port}}|{erlang_node,{ErlNode}}
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(logger_infra_server).

-behaviour(gen_server).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------

%% External exports
-export([
	]).


%% gen_server callbacks



-export([init/1, handle_call/3,handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {loaded,
		spec_list
	       }).

%% ====================================================================
%% External functions
%% ====================================================================


%% ====================================================================
%% Server functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function: init/1
%% Description: Initiates the server
%% Returns: {ok, State}          |
%%          {ok, State, Timeout} |
%%          ignore               |
%%          {stop, Reason}
%% --------------------------------------------------------------------
init([]) ->

    {ok, #state{}}.

%% --------------------------------------------------------------------
%% Function: handle_call/3
%% Description: Handling call messages
%% Returns: {reply, Reply, State}          |
%%          {reply, Reply, State, Timeout} |
%%          {noreply, State}               |
%%          {noreply, State, Timeout}      |
%%          {stop, Reason, Reply, State}   | (terminate/2 is called)
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_call({read_all},_From, State) ->
    Reply=lib_logger_infra:read_all(),
    {reply, Reply, State};
handle_call({read_all,NumLatesInfo},_From, State) ->
    Reply=  Reply=lib_logger_infra:read_all(NumLatesInfo),
    {reply, Reply, State};
handle_call({read_alert},_From, State) ->
    Reply=ok,
    {reply, Reply, State};
handle_call({read_alert,NumLatesInfo},_From, State) ->
    Reply=ok,
    {reply, Reply, State};
handle_call({read_ticket},_From, State) ->
    Reply=ok,
    {reply, Reply, State};
handle_call({read_ticket,NumLatesInfo},_From, State) ->
    Reply=ok,
    {reply, Reply, State};
handle_call({read_info},_From, State) ->
    Reply=ok,
    {reply, Reply, State};
handle_call({read_info,NumLatesInfo},_From, State) ->
    Reply=ok,
    {reply, Reply, State};

handle_call({stop}, _From, State) ->
    {stop, normal, shutdown_ok, State};

handle_call(Request, From, State) ->
    Reply = {unmatched_signal,?MODULE,Request,From},
    {reply, Reply, State}.

%% --------------------------------------------------------------------
%% Function: handle_cast/2
%% Description: Handling cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_cast({log,Info}, State) ->
    lib_logger_infra:store(Info),
    {noreply, State};

handle_cast({alert,Info}, State) ->

    {noreply, State};
handle_cast({ticket,Info}, State) ->

    {noreply, State};
handle_cast({info,Info}, State) ->

    {noreply, State};

handle_cast(Msg, State) ->
    io:format("unmatched match cast ~p~n",[{Msg,?MODULE,?LINE}]),
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: handle_info/2
%% Description: Handling all non call/cast messages
%% Returns: {noreply, State}          |
%%          {noreply, State, Timeout} |
%%          {stop, Reason, State}            (terminate/2 is called)
%% --------------------------------------------------------------------
handle_info({Id, desired_state_ret,ResultList}, State) ->
    io:format("~p~n",[{time(),node(),?MODULE,?FUNCTION_NAME,?LINE,
		      Id,desired_state_ret,ResultList}]), 
    {noreply, State};

handle_info(Info, State) ->
    io:format("unmatched handle_info ~p~n",[{Info,?MODULE,?LINE}]), 
    {noreply, State}.

%% --------------------------------------------------------------------
%% Function: terminate/2
%% Description: Shutdown the server
%% Returns: any (ignored by gen_server)
%% --------------------------------------------------------------------
terminate(_Reason, _State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------
