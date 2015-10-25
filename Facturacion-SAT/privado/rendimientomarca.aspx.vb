Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_rendimientomarca
    Inherits System.Web.UI.Page
    Dim CodPage As Integer = 1009
    Dim datos As New datos()

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        infoMenu()
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), CodPage) Then
            Response.Redirect("403")
        End If
        datos.CargarCombo(DropDepartamentos, "select id,descripcion from departamentos")
        datos.CargarCombo(DropAIM, "Select modelo, modelo from _Vehiculos where modelo not in (0) group by modelo ")
        datos.CargarCombo(DropAFM, "Select modelo, modelo from _Vehiculos where modelo not in (0) group by modelo order by modelo DESC")

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
