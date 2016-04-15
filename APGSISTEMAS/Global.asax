<%@ Application Language="VB" %>
<%@ Import Namespace="System.Web.Routing" %> 

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        RegistraRuta()
    End Sub
    Public Sub RegistraRuta()
        RouteTable.Routes.MapPageRoute("Index", "Dashboard", "~/privado/Default.aspx")
        RouteTable.Routes.MapPageRoute("LogOut", "LogOut", "~/privado/logout.aspx")
        RouteTable.Routes.MapPageRoute("LogIn", "LogIn", "~/login.aspx")
        RouteTable.Routes.MapPageRoute("Error403", "403", "~/error/error403.aspx")
        RouteTable.Routes.MapPageRoute("Error404", "404", "~/error/error404.aspx")
        RouteTable.Routes.MapPageRoute("Error500", "500", "~/error/error500.aspx")
        RouteTable.Routes.MapPageRoute("Error503", "503", "~/error/error503.aspx")
        RouteTable.Routes.MapPageRoute("ErrorTimeOut", "TimeOut", "~/error/errorTimeOut.aspx")
        RouteTable.Routes.MapPageRoute("IngresoYSalida", "IngresoYSalida", "~/privado/entradaysalida.aspx")
        RouteTable.Routes.MapPageRoute("Perfil", "Perfil", "~/privado/perfil.aspx")
        RouteTable.Routes.MapPageRoute("IngresoFactura", "IngresoFactura", "~/privado/ingresofacturaviaticos.aspx")
        RouteTable.Routes.MapPageRoute("EnviarLiquidacion", "EnviarLiquidacion", "~/privado/enviarliquidacion.aspx")
        RouteTable.Routes.MapPageRoute("CargaDeFacturas", "CargaDeFacturas", "~/privado/cargarfacturasversatec.aspx")
        RouteTable.Routes.MapPageRoute("GuiaPiloto", "GuiaPiloto", "~/privado/guiapiloto.aspx")
        RouteTable.Routes.MapPageRoute("RendimientoPorMarca", "RendimientoPorMarca", "~/privado/rendimientomarca.aspx")
        RouteTable.Routes.MapPageRoute("RecibosViaticos", "RecibosViaticos", "~/privado/recibosdeviaticos.aspx")
        RouteTable.Routes.MapPageRoute("Clientes", "Clientes", "~/privado/Clientes.aspx")
        RouteTable.Routes.MapPageRoute("Proveedores", "Proveedores", "~/privado/Proveedores.aspx")
        RouteTable.Routes.MapPageRoute("Productos", "Productos", "~/privado/Productos.aspx")
        RouteTable.Routes.MapPageRoute("Categorias", "Categorias", "~/privado/Categorias.aspx")
        RouteTable.Routes.MapPageRoute("Unidad", "Unidad", "~/privado/Unidad.aspx")


        RouteTable.Routes.MapPageRoute("CargarFacturas", "CargarFacturas", "~/privado/CargarFacturas.aspx")
        RouteTable.Routes.MapPageRoute("IngresoDirectorio", "IngresoDirectorio", "~/privado/IngresoDirectorio.aspx")
         RouteTable.Routes.MapPageRoute("Directorios", "Directorios", "~/privado/Directorios.aspx")

    End Sub
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub
    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
    End Sub
    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

</script>