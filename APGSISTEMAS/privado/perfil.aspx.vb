Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_perfil
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        infoMenu()
    End Sub
    Protected Sub Subir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Subir.Click
        Dim str As String
        Dim Codigo As String
        Try
            Using conexion As New MySqlConnection()
                conexion.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString
                conexion.Open()
                Dim comando As MySqlCommand
                comando = conexion.CreateCommand
                comando.CommandType = Data.CommandType.Text
                
                Dim files As HttpFileCollection = Request.Files
                LblUser.Text = Request.Cookies("UserSettings")("user") + "'"
                Dim postedFile As HttpPostedFile = files(0)
                Dim nbr = postedFile.FileName.ToString
                Dim extencion As Array = Split(nbr, ".")
                Dim path =""
                FilePerfil.SaveAs(Server.MapPath("~/privado/images/perfil/" & Request.Cookies("UserSettings")("user") & "." & extencion(extencion.Length - 1)))
                str = "UPDATE userw SET imagen='" & Request.Cookies("UserSettings")("user") & "." & extencion(extencion.Length - 1) & "' where username='" + Request.Cookies("UserSettings")("user") + "'"
                comando.CommandText = str
                comando.ExecuteNonQuery()
                Response.Cookies("UserSettings")("Imagen") = Request.Cookies("UserSettings")("user") & "." & extencion(extencion.Length - 1)
                'Codigo = "function(){ jQuery.gritter.add({ title:'Operacion Exitosa!', text:'Ha Cargado Su Imagen Exitosamente.', class_name:'growl-success', image:'images/screen.png', sticky: false, time:''}); return false;};"
                'ScriptManager.RegisterStartupScript(Subir, GetType(Page), "Alerta", Codigo, True)
            End Using
        Catch ex As Exception
            ' Codigo = "function(){ jQuery.gritter.add({ title:'Ha Ocurrido Un Error!', text:'Ha Ocurrido Un Error, Favor Intentar Mas Tarde.', class_name:'growl-danger', image:'images/screen.png', sticky: false, time:''}); return false;};"
            ' ScriptManager.RegisterStartupScript(Editar, GetType(Page), "Alerta", Codigo, True)

        End Try
    End Sub
    Sub infoMenu()
        If (Not Request.Cookies("UserSettings") Is Nothing) Then
            LblUsuario.Text = Request.Cookies("UserSettings")("user")
            LblUser.Text = Request.Cookies("UserSettings")("user")
            NombreCompleto.Text = Request.Cookies("UserSettings")("NombreUsuario")
            Compania.Text = Request.Cookies("UserSettings")("Company")
            ImagenMenu.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
            ImagenPerfil.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
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
