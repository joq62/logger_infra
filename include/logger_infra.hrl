-define(logger_info(Severity,Msg,Args),
	{date(),time(),node(),Severity,Msg,?MODULE,?FUNCTION_NAME,?LINE,Args,new}).
