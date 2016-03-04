Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class login
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Clear()
        TxtUser.Focus()
    End Sub
    Protected Sub BtnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnLogin.Click
        Try
            Dim str As String

            Dim Adaptador As New MySqlDataAdapter
            Dim TablaUsuario As New DataTable
            Using conexion As New MySqlConnection()
                conexion.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString
                conexion.Open()
                Dim comando As MySqlCommand
                comando = conexion.CreateCommand
                comando.CommandType = Data.CommandType.Text
                comando.Parameters.Add("@id_usr", MySqlDbType.VarChar, 15).Value = TxtUser.Text
                comando.Parameters.Add("@pass_usr", MySqlDbType.Blob).Value = TxtPass.Text
                'str = "select username, FirstName, LastName, company, imagen,IdPersonal from userw where username = @id_usr and password = aes_encrypt(@pass_usr, 'gentrac') and status=true; "
                str = "call Login(@id_usr,@pass_usr);"
                comando.CommandText = str
                Adaptador.SelectCommand = comando
                Adaptador.Fill(TablaUsuario)
                If TablaUsuario.Rows.Count > 0 Then
                    Response.Cookies("UserSettings")("IdUser") = TablaUsuario.Rows(0).Item("ID")
                    Response.Cookies("UserSettings")("user") = TablaUsuario.Rows(0).Item("username")
                    Response.Cookies("UserSettings")("NombreUsuario") = TablaUsuario.Rows(0).Item("FirstName") & " " & TablaUsuario.Rows(0).Item("LastName")
                    Response.Cookies("UserSettings")("Company") = TablaUsuario.Rows(0).Item("company")
                    Response.Cookies("UserSettings")("IdPersonal") = TablaUsuario.Rows(0).Item("IdPersonal")
                    Response.Cookies("UserSettings")("Flota") = TablaUsuario.Rows(0).Item("flotilla")
                    If IsDBNull(TablaUsuario.Rows(0).Item("imagen")) = False Then
                        Response.Cookies("UserSettings")("Imagen") = TablaUsuario.Rows(0).Item("imagen")
                    Else
                        Response.Cookies("UserSettings")("Imagen") = "no-user-image.png"
                    End If

                    Response.Cookies("UserSettings").Expires = DateTime.Now.AddDays(1)
                    comando.Dispose()
                    FormsAuthentication.RedirectFromLoginPage(TxtUser.Text, False)
                Else
                    LblEstado.Text = "Datos incorrectos"
                End If
            End Using
        Catch ex As Exception
        End Try
    End Sub
End Class
