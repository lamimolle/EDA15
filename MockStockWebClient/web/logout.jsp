<%@page import="middleware.communication.Subscriber"%>
<%@page import="ch.unil.trader.Trader"%>

<%!  private Trader trader = null;
     private Subscriber subscriber = null;
%>
<%	trader = (Trader) session.getAttribute("trader");
    subscriber = (Subscriber) session.getAttribute("subscriber");
    if (subscriber != null)
    subscriber.close();
    if (trader.getProducer() != null)
    trader.getProducer().close();
    response.sendRedirect("index.jsp");
%>