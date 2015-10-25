
Partial Class privado_vehiculos
    Inherits System.Web.UI.Page
    Dim datos As New datos
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        datos.CargarComboDepartamentos(DropDepartamento)
        datos.CargarComboTipoVehiculo(DropTipoVehiculo)
        datos.CargarComboUsuario(DropUsuario)




    End Sub
End Class
