<%@page import="middleware.exception.ProducerException"%>
<%@page import="java.util.HashMap"%>
<%@page import="middleware.communication.Publisher"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.jms.JMSException"%>
<%@page import="middleware.common.StockProduct"%>
<%@page import="javax.jms.ObjectMessage"%>
<%@page import="javax.jms.TextMessage"%>
<%@page import="middleware.common.Result"%>
<%@page import="javax.jms.Message"%>
<%@page import="middleware.exception.SubscriberException"%>
<%@page import="javax.xml.bind.Marshaller.Listener"%>
<%@page import="javax.jms.MessageListener"%>
<%@page import="middleware.communication.Subscriber"%>
<%@page import="middleware.communication.Producer"%>
<%@page import="ch.unil.trader.Trader"%>

<%! private final String controlQueueName = "msControl";
    private final String updateTopicName = "msUpdate";
    private Subscriber subscriber;
    private Producer producer;
    private Result queryResult;
    private String query;
    private Trader trader;
%>

<%  String name = request.getParameter("name");
    this.queryResult = Result.OK;

    if (!name.trim().equals("")) {
        this.producer = new Producer(controlQueueName);
        this.producer.start();

        this.trader = new Trader(name, producer);

        subscriber = new Subscriber(updateTopicName, new MessageListener() {

            @Override
            public void onMessage(Message message) {
                if (message instanceof TextMessage) {
                    String result = null;

                    if (result.endsWith("Ok")) {
                        queryResult = Result.OK;
                    } else {
                        queryResult = Result.FAIL;
                    }
                } else if (message instanceof ObjectMessage) {
                    StockProduct sp = null;
                    try {
                        sp = (StockProduct) ((ObjectMessage) message).getObject();

                        if (Trader.updateStock(sp)) {
                            trader.addStock(sp);
                        }
                    } catch (JMSException e) {
                        System.err.println("Stock list couldn't be read: " + e.getMessage());
                    }
                }
            }
        ;
        });
        this.subscriber.start();

            session.setAttribute("username", name);
            session.setAttribute("trader", trader);
            response.sendRedirect("trader");

    } else {
        session.setAttribute("error", "The name cannot be empty.");
        response.sendRedirect("errormessage.jsp");
    }
%>