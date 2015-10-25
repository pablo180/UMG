Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_reporteejecutivo
    Inherits System.Web.UI.Page
    Dim CodPage As Integer = 1007
    Dim datos As New datos()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), CodPage) Then
            Response.Redirect("403")
        End If
        infoMenu()
        datos.CargarCombo(DropOpcion, "select Id,Descripcion from opcionactividaddiaria;")
        If Request.Cookies("UserSettings")("Flota") = "0" Then
            datos.CargarCombo(DropDepartamentos, "select id,descripcion from departamentos")
        Else
            datos.CargarCombo(DropDepartamentos, "select id,descripcion from departamentos where id in(" & Request.Cookies("UserSettings")("Flota") & ")")
        End If
        datos.CargarCombo(DropFiltro, "select Id,Descripcion from operadorlogico;")
        datos.CargarComboYears(DropYear)
        datos.CargarComboMes(DropMes)

        If DropDepartamentos.SelectedValue = "0" Then
            datos.CargarComboMas(DropVehiculo, "select Id,codigo from _vehiculos;", 0)
        Else
            datos.CargarComboMas(DropVehiculo, "select Id,codigo from _vehiculos where departamento=" + DropDepartamentos.SelectedValue + ";", 0)
        End If

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
