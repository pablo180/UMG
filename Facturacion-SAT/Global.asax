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
        RouteTable.Routes.MapPageRoute("RendimientoVehiculo", "RendimientoVehiculo", "~/privado/rendimientovehiculo.aspx")
        RouteTable.Routes.MapPageRoute("IngresoFactura", "IngresoFactura", "~/privado/ingresofacturaviaticos.aspx")
        RouteTable.Routes.MapPageRoute("Recorrido", "Recorrido", "~/privado/recorridoUnidad.aspx")
        RouteTable.Routes.MapPageRoute("EnviarLiquidacion", "EnviarLiquidacion", "~/privado/enviarliquidacion.aspx")
        RouteTable.Routes.MapPageRoute("CargaDeFacturas", "CargaDeFacturas", "~/privado/cargarfacturasversatec.aspx")
        RouteTable.Routes.MapPageRoute("ReservacionDeVehiculo", "ReservacionDeVehiculo", "~/privado/reservavehiculo.aspx")
        RouteTable.Routes.MapPageRoute("ReservacionesDeVehiculos", "ReservacionesDeVehiculos", "~/privado/reservacionesvehiculos.aspx")
        RouteTable.Routes.MapPageRoute("Liquidaciones", "Liquidaciones", "~/privado/liquidaciones.aspx")
        RouteTable.Routes.MapPageRoute("MisReservaciones", "MisReservaciones", "~/privado/MisReservaciones.aspx")
        RouteTable.Routes.MapPageRoute("EstadoVehiculo", "EstadoVehiculo", "~/privado/estadoactualvehiculo.aspx")
        RouteTable.Routes.MapPageRoute("CalendarioVehiculo", "CalendarioVehiculo", "~/privado/calendarizacionvehiculo.aspx")
        RouteTable.Routes.MapPageRoute("ReservacionesVehiculos", "ReservacionesVehiculos", "~/privado/Reservaciones.aspx")
        RouteTable.Routes.MapPageRoute("MantenimientoPreventivo", "MantenimientoPreventivo", "~/privado/mantenimientos.aspx")
        RouteTable.Routes.MapPageRoute("ProgramacionUnidad", "ProgramacionUnidad", "~/privado/ProgramacionUnidad.aspx")
        RouteTable.Routes.MapPageRoute("ReporteEjecutivo", "ReporteEjecutivo", "~/privado/reporteejecutivo.aspx")
        RouteTable.Routes.MapPageRoute("GuiaPiloto", "GuiaPiloto", "~/privado/guiapiloto.aspx")
        RouteTable.Routes.MapPageRoute("PorcentajeCarPool", "PorcentajeCarPool", "~/privado/porcentajecarpool.aspx")
        RouteTable.Routes.MapPageRoute("RendimientoPorMarca", "RendimientoPorMarca", "~/privado/rendimientomarca.aspx")
        RouteTable.Routes.MapPageRoute("RecibosViaticos", "RecibosViaticos", "~/privado/recibosdeviaticos.aspx")
        RouteTable.Routes.MapPageRoute("Vehiculos", "Vehiculos", "~/privado/vehiculos.aspx")
        RouteTable.Routes.MapPageRoute("ReporteUtilizacionFlota", "ReporteUtilizacionFlota", "~/privado/ReporteUtilizacionFlota.aspx")
        RouteTable.Routes.MapPageRoute("reportellantas", "reportellantas", "~/privado/reportellantas.aspx")
        RouteTable.Routes.MapPageRoute("CargarFacturas", "CargarFacturas", "~/privado/CargarFacturas.aspx")
        RouteTable.Routes.MapPageRoute("ReporteLL", "ReporteLL", "~/privado/ReporteLL.aspx")
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