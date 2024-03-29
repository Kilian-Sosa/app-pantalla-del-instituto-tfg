<%@page import="java.util.ArrayList"%>
<%@page import="POJOs.News"%>
<%@page import="controller.ControlNewsManager"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrador de Noticias</title>

        <!-- CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" />
        
        <!-- JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    </head>
    
    <body>
        <!-- JAVA -->
        <%
            if(session.getAttribute("email") == null){
                session.setAttribute("flag", false);
                response.sendRedirect("login.jsp");
            } 
            
            String url = "";
            //url = "https://avatars.dicebear.com/api/initials/" + session.getAttribute("email").toString() + ".svg?size=70&r=50";
            url = "https://avatars.dicebear.com/api/identicon/" + session.getAttribute("email").toString() + ".svg?b=white&size=70&r=50";
            
            String action = request.getParameter("action");
            String actionA = "" + session.getAttribute("action");
            int id = 0;
            
            ControlNewsManager manager = new ControlNewsManager();
            
            if(action != null || actionA != null){
                if(action == null) action = "";
                if(action.compareTo("delete") == 0){
                    id = Integer.parseInt(request.getParameter("id"));
                    manager.setID(id);
                        
                    int cont = manager.execute(3);
                    if(cont != 1){%>
                        <div class="alert alert-danger" role="alert">Ha habido un error al eliminar la noticia</div>
                    <%}else{%>
                        <div class="alert alert-success" role="alert">Se ha eliminado la noticia correctamente</div>
                    <%} 
                }else{
                    session.removeAttribute("action");
                    if(actionA.compareTo("edit") == 0){%>
                        <div class="alert alert-success" role="alert">Se ha modificado correctamente la noticia</div>  
                    <%}else if(actionA.compareTo("insert") == 0){%>
                        <div class="alert alert-success" role="alert">Se ha insertado la noticia correctamente</div>
                    <%}   
                }
            }    
            manager.execute(0);
            ArrayList<News> list = manager.getList();
        %>
        <div class="container-fluid">
            <!-- HEADER -->
            <div class="row py-3">
                <div class="col-12">
                    <img class="float-start" src="https://cdn.discordapp.com/attachments/944571344786432021/945247676029616178/logo.png" width="200" height="150">
                    <div class="float-end col-2 me-4">
                        <img class="pt-5 mx-auto d-block" src="<%=url%>">
                        <p class="fs-5 font-monospace text-center"><%=session.getAttribute("name")%></p>
                    </div>
                </div>
                
                <div class="col-12">
                    <p class="fs-1 text-center font-monospace">Gestor de Noticias</p>
                </div>
            </div>
            
            <!-- NEWS TABLE -->
            <div class="row col-11 mx-auto">
                <div class="col-12">
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <td><a href="news.jsp">T�tulo</a></th>
                                <th><a href="news.jsp">Autor</a></th>
                                <th><a href="news.jsp">Dia Inicio</a></th>
                                <th><a href="news.jsp">Dia Fin</a></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>                         
                            <%for(int i = 0; i < list.size(); i++){
                                News news = list.get(i);
                            %>
                                <tr>
                                    <td><%=news.getTitle()%></td>
                                    <td><%=news.getAuthor()%></td>
                                    <td><%=news.getDate_Init()%></td>
                                    <td><%=news.getDate_Fin()%></td>
                                    <td>
                                        <!-- EDIT BUTTON -->
                                        <form method="POST" action="form_news.jsp">
                                            <div class="d-grid gap-2">
                                                <input type="hidden" name="action" value="edit">
                                                <input name="id" type="hidden" value="<%=news.getID()%>">
                                                <input name="url_image" type="hidden" value="<%=news.getUrl_Image()%>">
                                                <input name="title" type="hidden" value="<%=news.getTitle()%>">
                                                <input name="description" type="hidden" value="<%=news.getDescription()%>">
                                                <input name="author" type="hidden" value="<%=news.getAuthor()%>">
                                                <input name="dateinit" type="hidden" value="<%=news.getDate_Init()%>">
                                                <input name="datefin" type="hidden" value="<%=news.getDate_Fin()%>">
                                                <input type="submit" value="Editar" class="btn btn-primary">
                                            </div>
                                        </form>
                                    </td>
                                    <td>
                                        <!-- DELETE BUTTON -->
                                        <form method="POST" action="news.jsp">
                                            <div class="d-grid gap-2">
                                                <input type="hidden" name="action" value="delete">
                                                <input name="id" type="hidden" value="<%=news.getID()%>">
                                                <input type="submit" value="Eliminar" class="btn btn-secondary">
                                            </div>
                                        </form>
                                    </td>
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
                    
            <div class="row py-5 col-11 mx-auto justify-content-evenly">
                <!-- RETURN BUTTON -->
                <div class="col-3">
                    <form method="POST" action="menu.jsp">
                        <div class="d-grid gap-2">
                            <input type="submit" value="Volver Atr�s" class="btn btn-secondary">
                        </div>
                    </form>
                </div>

                <!-- INSERT BUTTON -->
                <div class="col-9">
                    <form method="POST" action="form_news.jsp">
                        <div class="d-grid gap-2">
                            <input type="hidden" name="action" value="insert">
                            <input type="submit" action="insert" value="Insertar" class="btn btn-primary">
                        </div>
                    </form>
                </div>
                
                <!-- SCREEN BUTTON -->
                <div class="py-5 col-3">
                    <form method="POST" action="index.jsp">
                        <div class="d-grid gap-2">
                            <input type="submit" value="Modo Pantalla" class="btn btn-primary">
                        </div>
                    </form>
                </div>
            </div>
        </div> <!-- END CONTAINER -->
    </body>
</html>
