package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Account;
import model.AccountDetailDTO;
import service.AccountServiceImpl;

/**
 * Servlet implementation class Servlet
 */
@WebServlet("/core.do")
public class CoreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CoreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path
                + "/";
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        if ("login".equalsIgnoreCase(action)) {
            System.out.println("开始登录");
            String id = request.getParameter("accountid");
            String pwd = request.getParameter("pwd");
            AccountServiceImpl aServ = new AccountServiceImpl();
            try {
                Account acc = aServ.loginAccount(id, pwd);
                HttpSession session = request.getSession();
                session.setAttribute("account", acc);
//				response.sendRedirect("/view/index.jsp");
                if (acc == null) {
                    request.setAttribute("err", "101");
                    RequestDispatcher disp = request.getRequestDispatcher("/login.jsp");
                    disp.forward(request, response);
                }
                RequestDispatcher disp = request.getRequestDispatcher("/index.jsp");
                disp.forward(request, response);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                out.println("服务器出现异常");
            }
        } else if ("addMoney".equalsIgnoreCase(action)) {
            System.out.println("进入存钱");
            String accountid = request.getParameter("accountid");
            double amount = Double.parseDouble(request.getParameter("amount"));
            Account acc = new Account();
            acc.setAccountid(accountid);
            System.out.println(acc.getAccountid());
            AccountServiceImpl aServ = new AccountServiceImpl();
            try {
                Boolean b = aServ.saveMoney(acc, amount);
                if (b)
                    response.sendRedirect(path + "/index.jsp");
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                out.println("服务器出现异常");
            }
        } else if ("draw".equalsIgnoreCase(action)) {
            System.out.println("进入取钱");
            String accountid = request.getParameter("accountid");
            double amount = Double.parseDouble(request.getParameter("amount"));
            Account acc = new Account();
            acc.setAccountid(accountid);
            System.out.println(acc.getAccountid());
            AccountServiceImpl aServ = new AccountServiceImpl();
            try {
                Boolean b = aServ.drawMoney(acc, amount);
                if (b)
                    response.sendRedirect(path + "/index.jsp");
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                if (e.getMessage() == "250") {
                    request.setAttribute("err", "250");
                    RequestDispatcher disp = request.getRequestDispatcher("/draw.jsp");
                    disp.forward(request, response);
                } else {
                    out.println("服务器出现异常");
                }
            }
        } else if ("transger".equalsIgnoreCase(action)) {
            System.out.println("首先查询是否存在用户");
            String accountid = request.getParameter("accountid");
            String accountid2 = request.getParameter("accountid2");
            double amount = Double.parseDouble(request.getParameter("amount"));
            AccountServiceImpl aServ = new AccountServiceImpl();
            try {
                Account acc2 = aServ.findAccunt(accountid2);
                if (acc2 == null) {
                    request.setAttribute("err", "111");
                    RequestDispatcher disp = request.getRequestDispatcher("/transger.jsp");
                    disp.forward(request, response);
                } else if (acc2.getAccountid().equals(accountid)) {
                    request.setAttribute("err", "112");
                    RequestDispatcher disp = request.getRequestDispatcher("/transger.jsp");
                    disp.forward(request, response);
                } else {
                    request.setAttribute("account2", acc2);
                    request.setAttribute("amount", amount);
                    RequestDispatcher disp = request.getRequestDispatcher("/transger1.jsp");
                    disp.forward(request, response);
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                out.println("服务器出现异常");
            }
        } else if ("transger1".equalsIgnoreCase(action)) {
            System.out.println("开始转账");
            String accountid = request.getParameter("accountid"); //自身id
            String accountid2 = request.getParameter("accountid2"); //对方Id
            double amount = Double.parseDouble(request.getParameter("amount")); //转账金额
            AccountServiceImpl aServ = new AccountServiceImpl();
            Account acc = new Account();
            acc.setAccountid(accountid);
            Account acc2 = new Account();
            acc2.setAccountid(accountid2);
            try {
                boolean b = aServ.transferMoney(acc, acc2, amount);
                if (b) {
                    response.sendRedirect(path + "/index.jsp");
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                if (e.getMessage() == "250") {
                    request.setAttribute("err", "250");
                    RequestDispatcher disp = request.getRequestDispatcher("/transger.jsp");
                    disp.forward(request, response);
                } else {
                    out.println("服务器出现异常");
                }
            }
        } else if ("quertRemain".equalsIgnoreCase(action)) {
            System.out.println("开始查询余额");
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("account");
            String accountid = acc.getAccountid();
            AccountServiceImpl aServ = new AccountServiceImpl();
            try {
                acc = aServ.findAccunt(accountid);
                session.setAttribute("account", acc);
                response.sendRedirect(path + "/queryRemainder.jsp");
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                out.println("服务器出现异常");
            }
        } else if ("detail".equalsIgnoreCase(action)) {
            System.out.print("开始查询明细");
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("account");
            AccountServiceImpl aServ = new AccountServiceImpl();
            try {
                ArrayList<AccountDetailDTO> al = aServ.queryTransactionDail(acc);
                System.out.println(al.size());
                request.setAttribute("arraylist", al);
                RequestDispatcher disp = request.getRequestDispatcher("/detail.jsp");
                disp.forward(request, response);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                out.println("服务器出现异常");
            }
        } else if ("updatePwd".equalsIgnoreCase(action)) {
            System.out.print("开始修改密码");
            HttpSession session = request.getSession();
            Account acc = (Account) session.getAttribute("account");
            String pwd = request.getParameter("pwd");
            String newPwd = request.getParameter("newPwd");
            AccountServiceImpl aServ = new AccountServiceImpl();
            try {
                boolean b = aServ.updatePwd(acc, pwd, newPwd);
                if (b)
                    response.sendRedirect(path + "/index.jsp");
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                if (e.getMessage() == "260") {
                    request.setAttribute("err", "260");
                    RequestDispatcher disp = request.getRequestDispatcher("/changePassword1.jsp");
                    disp.forward(request, response);
                } else {
                    out.println("服务器出现异常");
                }
            }
        } else if ("exit".equalsIgnoreCase(action)){
            System.out.print("退出");
            HttpSession session = request.getSession();
            session.removeAttribute("account");
            session.removeAttribute("arraylist");
            response.sendRedirect(path + "/login.jsp");
        }
    }


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
