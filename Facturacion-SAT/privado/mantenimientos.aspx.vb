
Partial Class privado_mantenimientos
    Inherits System.Web.UI.Page
    Dim datos As New datos
    Dim page As Integer = 1005
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), Page) Then
            Response.Redirect("403")
        End If
        infoMenu()
        datos.CargarCombo(DropServicio, "select Id, concat(pieza,' - ',descripcion) Descripcion from tfallas;")
        datos.CargarCombo(DropDestino, "select concat(Nombre, ' - ', Direccion),Nombre from proveedores;")
        datos.CargarComboDepartamentos(DropDepartamento)
    End Sub
    Sub infoMenu()
        LblUsuario.Text = Request.Cookies("UserSettings")("user")
        LblUser.Text = Request.Cookies("UserSettings")("user")
        ImagenMenu.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
        ImagenUsuario.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
    End Sub
End Class
