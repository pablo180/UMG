﻿
Partial Class privado_MisReservaciones
    Inherits System.Web.UI.Page
    Dim page As Integer = 3003
    Dim datos As New datos()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), page) Then
            Response.Redirect("403")
        End If
        datos.CargarComboMas(DropEstadoReservacion, "select Id,Descripcion from estadoreservacion;", "%")
        infoMenu()
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
