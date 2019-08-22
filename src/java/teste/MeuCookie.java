/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package teste;

/**
 *
 * @author VictorSantana
 */import java.io.IOException;
import java.io.PrintWriter;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet("/MeuCookie")
public class MeuCookie extends HttpServlet {
    private static final long serialVersionUID = 1L;
 
    public MeuCookie() {
        super();
    }
 
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
 
        // Mostra pagina HTML
        response.setContentType("text/html");
 
        PrintWriter html = response.getWriter();
 
        html.println("<html>");
        html.println("<body>");
        html.println("<h1>Desenvolvimento Aberto</h1>");
        html.println("<h2>Cookies - Memoriza Dados</h2>");
 
        // Formulário processa este mesmo Servlet e o método DoPost
        html.println("<form action='MeuCookie' method='post'>");
 
        // Manipula cookie
        String nome = getDaCookieNome(request);
        if (nome != null)
            html.println("Nome: " + nome + " <br> ");
        else {
            html.println("Nome: <input type='text' name='nome' size ='55' /> ");
            html.println("<input type='submit' name='adiciona' value='Adicionar'/> <br>");
        }
 
        html.println("</form>");
        html.println("</body>");
        html.println("</html>");
    }
 
    private String getDaCookieNome(HttpServletRequest request) {
         
        // Recupera cookie
        for (Cookie cookie : request.getCookies())
            if (cookie.getName().equals("DAname1"))
                return cookie.getValue();
 
        return null;
    }
 
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
 
        String nome = getDaCookieNome(request);
        if (nome == null) {
 
            nome = request.getParameter("nome");
 
            // Cria Cookie
            Cookie cookie = new Cookie("DAname1", nome);
             
            // Redireciona página
            response.addCookie(cookie);
 
            // Redireciona página
            response.sendRedirect("MeuCookie");
        }
    }
 
}