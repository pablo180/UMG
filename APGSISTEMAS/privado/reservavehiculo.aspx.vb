Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_reservavehiculo
    Inherits System.Web.UI.Page
    Dim page As Integer = 3001
    Dim datos As New datos()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), page) Then
            Response.Redirect("403")
        End If
        datos.CargarCombo(ListTipoVehiculo, "select tv.id_tipo_vehiculo IdTipoVehiculo,  tv.tipo_vehiculo TipoVehiculo from  (select IdTipoVehiculo, Prioridad from prioridadvehiculo where IdDepartamento=( select idArea from personal where IdEmpleado=" & Request.Cookies("UserSettings")("IdPersonal") & ")) p right join tipo_vehiculo tv on p.IdTipoVehiculo=tv.id_tipo_vehiculo where tv.reserva=true order by p.Prioridad is null;")
        datos.CargarCombo(ListAlerta, "select Id,Descripcion from alerta;")
        Dim str As String

        Dim Adaptador As New MySqlDataAdapter
        Dim TablaUsuario As New DataTable
        Using conexion As New MySqlConnection()
            conexion.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString
            conexion.Open()
            Dim comando As MySqlCommand
            comando = conexion.CreateCommand
            comando.CommandType = Data.CommandType.Text
            str = "SELECT nombre,Correo FROM personal where idEmpleado=" & Request.Cookies("UserSettings")("IdPersonal")
            comando.CommandText = str
            Adaptador.SelectCommand = comando
            Adaptador.Fill(TablaUsuario)
            If TablaUsuario.Rows.Count > 0 Then
                TxtNombreEmpleado.Text = TablaUsuario.Rows(0).Item("nombre")
                If Not IsDBNull(TablaUsuario.Rows(0).Item("Correo")) Then
                    TxtCorreoEmpleado.Text = TablaUsuario.Rows(0).Item("Correo")
                End If
            End If
        End Using
        'MsgBox(datos.validaCorreo("brevolorio@hotmail.com"))
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
    'Protected Sub BtnAgregarReservacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnAgregarReservacion.Click
    ' Dim Codigo As String = "$(document).ready(function(){ jQuery.gritter.add({ title:'Ha Ocurrido Un Error!', text:'Ha Ocurrido Un Error, Favor Intentar Mas Tarde.', class_name:'growl-danger', image:'images/screen.png', sticky: false})});"
    'ScriptManager.RegisterStartupScript(BtnAgregarReservacion, GetType(Page), "Alerta", Codigo, True)
    ' End Sub
End Class
