Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_recorridoUnidad
    Inherits System.Web.UI.Page
    Dim CodPage As Integer = 1003
    Dim datos As New datos()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), CodPage) Then
            Response.Redirect("403")
        End If
        infoMenu()
        If Request.Cookies("UserSettings")("Flota") = "0" Then
            datos.CargarCombo(DropDepartamentos, "select id,descripcion from departamentos")
        Else
            datos.CargarCombo(DropDepartamentos, "select id,descripcion from departamentos where id in(" & Request.Cookies("UserSettings")("Flota") & ")")
        End If
        datos.CargarComboYears(DropYear)
        datos.CargarComboMes(DropMes)
        Page.ClientScript.RegisterStartupScript(GetType(Page), "Active", "$(document).ready(function(){$('#" & CodPage & "').addClass('active')});", True)
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
