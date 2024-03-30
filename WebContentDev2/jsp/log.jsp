<%@ page language="java" import="java.io.*, java.time.*" contentType= "text/html; charset=utf8" pageEncoding="utf8"%>
<%!
	public void writeLog( String message, HttpServletRequest request, HttpSession session )
	{
		try 
		{
			
			final String logFileName = "/usr/local/tomcat/webapps/ROOT/book/jsp/log.txt";	 
			BufferedWriter writer = new BufferedWriter( new FileWriter( logFileName, true ) );

			writer.append( "\nTime:\t" + LocalDate.now() + " " + LocalTime.now() 
				+ "\tSessionID:\t" + session.getId()				
				+ "\tURI:\t" + request.getRequestURI()				
				+ "\tPrevious:\t" + request.getHeader("referer") 		
				+ "\tBrowser:\t" + request.getHeader("User-Agent") 		
				+ "\tMessage:\t" + message );

			writer.close();
		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
%>
