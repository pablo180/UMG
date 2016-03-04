
Imports System.Text
Imports System.Reflection
Imports System.Data
Imports System.Web
Imports MySql.Data.MySqlClient

Imports System.Data.OleDb
Imports System.IO
Imports System.Configuration
Partial Class privado_CargarFacturas
    Inherits System.Web.UI.Page
    Dim page As Integer = 10001
    Dim datos As New datos()
    Dim conexion As MySqlConnection

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), page) Then
            Response.Redirect("403")
        End If
        infoMenu()
        datos.CargarCombo(DropTipoDocumento, "select id,nombre from tipodefactura;")
        datos.CargarComboMasNA(DropVehiculo, "select Id,codigo from _vehiculos;")
        datos.CargarCombo(DropProducto, "select codigo, descripcion from inventario;")
        datos.CargarCombo(DropDepartamento, "select id,descripcion from departamentos ;")
        'datos.CargarCombo(TxtNitProveedor, "select nit,concat(nit,'-',Nombre) from proveedores;")
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

    Public Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If FileUpload1.HasFile Then
            Dim FileName As String = Path.GetFileName(FileUpload1.PostedFile.FileName)
            Dim Extension As String = Path.GetExtension(FileUpload1.PostedFile.FileName)
            Dim FolderPath As String = ConfigurationManager.AppSettings("FolderPath")

            Dim FilePath As String = Server.MapPath(FolderPath + FileName)
            FileUpload1.SaveAs(FilePath)
            TxtFilePath.Text = FilePath.Replace("\", "/")
            TxtExtension.Text = Extension
            TxtYes.Text = "Yes"

            'Import_To_Grid(FilePath, Extension, "Yes")
        End If
    End Sub

   



End Class
