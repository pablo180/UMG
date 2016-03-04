Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_Default
    Inherits System.Web.UI.Page

    Dim MyDB As New MyDB
    Dim datos As New datos()
    Dim idLiquidacion As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        infoMenu()
        Dim user, consu, corre As String
        Dim conexion As New datos

        'datos.CargarCombo(DropDepartamentosFlota, "select id, descripcion from departamentos")
        'datos.CargarComboDepartamentos(DropDepartamentos)
        'datos.CargarComboTipoVehiculo(DropTipoVehiculo)
        'datos.CargarComboUsuario(DropUsuario)
    End Sub
    Sub infoMenu()
        If (Not Request.Cookies("UserSettings") Is Nothing) Then
            LblUsuario.Text = Request.Cookies("UserSettings")("user")
            LblUser.Text = Request.Cookies("UserSettings")("user")
            ImagenMenu.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
            ImagenUsuario.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
        Else
            Dim myCookie As HttpCookie
            myCookie = New HttpCookie("UserSettings")
            myCookie.Expires = DateTime.Now.AddDays(-1D)
            Response.Cookies.Add(myCookie)
            Response.Redirect("~/login")
        End If
    End Sub
End Class
