Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports MySql.Data.MySqlClient

Imports System.Data.OleDb
Imports System.IO
Imports System.Configuration
Imports System.Xml
Imports System.Xml.XmlNode
Imports System.Xml.XmlReader
Imports System.Xml.Serialization

Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()>
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class wsCliente
    Inherits System.Web.Services.WebService
    Dim datos As New datos()
    Dim MyDB As New MyDB
    Public Class CambiaPass
        Public StrRetorna As String = "0"
    End Class

    Public Class ClassCatalogoClientes
        Public IdEstado As Integer
        Public codigo As String
        Public Nombre As String
        Public Nit As String
        Public Telefono As String
        Public Direccion As String
        Public Correo As String
        Public Celular As Integer
        Public Estado As String
    End Class
    <WebMethod(EnableSession:=True)>
    Public Function CatalogoClientes(ByVal IdCliente As Integer) As List(Of [ClassCatalogoClientes])
        Dim result As List(Of [ClassCatalogoClientes]) = New List(Of ClassCatalogoClientes)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                consulta = "SELECT idCliente,Nombre,Nit,Telefono,Direccion,Correo,Celular,Estado FROM facturacionsat.cliente;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassCatalogoClientes
                    With elemento

                        .codigo = reader("idCliente")
                        If Not IsDBNull(reader("Nombre")) Then
                            .Nombre = reader("Nombre")
                        Else
                            .Nombre = ""
                        End If
                        If Not IsDBNull(reader("Nit")) Then
                            .Nit = reader("Nit")
                        Else
                            .Nit = ""
                        End If
                        If Not IsDBNull(reader("Telefono")) Then
                            .Telefono = reader("Telefono")
                        Else
                            .Telefono = ""
                        End If
                        If Not IsDBNull(reader("Direccion")) Then
                            .Direccion = reader("Direccion")
                        Else
                            .Direccion = ""
                        End If
                        If Not IsDBNull(reader("Correo")) Then
                            .Correo = reader("Correo")
                        Else
                            .Correo = ""
                        End If
                        If Not IsDBNull(reader("Celular")) Then
                            .Celular = reader("Celular")
                        Else
                            .Celular = ""
                        End If

                        If Not IsDBNull(reader("Estado")) Then
                            If (reader("Estado") = 1) Then
                                .Estado = "Alta"
                            Else
                                .Estado = "Baja"
                            End If

                        Else
                            .Estado = ""
                        End If

                        If Not IsDBNull(reader("Estado")) Then

                            .IdEstado = reader("Estado")
                        Else
                            .IdEstado = ""
                        End If

                    End With
                    result.Add(elemento)
                End While
            Finally
                conexion.Close()
            End Try
        End Using
        Return result
    End Function
End Class