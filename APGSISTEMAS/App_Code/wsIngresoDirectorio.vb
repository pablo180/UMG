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
Public Class wsIngresoDirectorio
    Inherits System.Web.Services.WebService
    Dim datos As New datos()
    Dim MyDB As New MyDB

    Public Class ClassGuardarCliente
        Public StrError As String = "0"
        Public IdVehiculo As Integer
    End Class
    <WebMethod()>
    Public Function GuardarDirectorio(ByVal NombreCompania As String, ByVal Direccion As String, ByVal Departamento As String, ByVal Municipio As String, ByVal Telefono As String, ByVal NombreContacto As String, ByVal Observacion As String, ByVal Correo As String) As List(Of ClassGuardarCliente)
        Dim result As List(Of ClassGuardarCliente) = New List(Of ClassGuardarCliente)
        Try
            Dim IdVehiculo As Integer = MyDB.MyInsertIdentity("INSERT INTO directorio (NombreCompañia, Direccion, Departamento, Municipio, Telefono, NombreContacto, Observacion, Correo) VALUES ('" & NombreCompania & "', '" & Direccion & "', '" & Departamento & "', '" & Municipio & "', '" & Telefono & "', '" & NombreContacto & "', '" & Observacion & "', '" & Correo & "');")



            Dim elemento As New ClassGuardarCliente
            elemento.StrError = "0"
            elemento.IdVehiculo = IdVehiculo
            result.Add(elemento)
        Catch ex As Exception
            Dim elemento As New ClassGuardarCliente
            elemento.StrError = ex.Message
            result.Add(elemento)
        Finally
        End Try
        Return result
    End Function



    Public Class ClassDirectorio
        Public id As String
        Public value As String
        Public title As String
    End Class
    <WebMethod(EnableSession:=True)>
    Public Function DirectorioMapa() As List(Of [ClassDirectorio])
        Dim result As List(Of [ClassDirectorio]) = New List(Of ClassDirectorio)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                consulta = "select dp.nom_deptoS as nombredepto,dp.nemonico_deptoS, count(Departamento) as valor from directorio d left join departamentos dp on d.Departamento = dp.id_deptoS group by d.Departamento;"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassDirectorio
                    With elemento


                        If Not IsDBNull(reader("nemonico_deptoS")) Then
                            .id = reader("nemonico_deptoS")
                        Else
                            .id = ""
                        End If
                        If Not IsDBNull(reader("valor")) Then
                            .value = reader("valor")
                        Else
                            .value = 0
                        End If
                        If Not IsDBNull(reader("nombredepto")) Then
                            .title = reader("nombredepto")
                        Else
                            .title = ""
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

    Public Class ClassDirectorioDescripcion
        Public IdDirectorio As Integer
        Public NombreCompania As String
        Public NombreDepartamento As String
        Public NombreMunicipio As String
        Public Telefono As String
        Public Contacto As String
        Public Observacion As String
        Public idDepto As Integer
        Public idMunicipio As Integer
        Public Correo As String

    End Class
    <WebMethod(EnableSession:=True)>
    Public Function DirectorioMapaDetalle(ByVal nemonico As String) As List(Of [ClassDirectorioDescripcion])
        Dim result As List(Of [ClassDirectorioDescripcion]) = New List(Of ClassDirectorioDescripcion)()
        Dim consulta As String
        Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
            Try
                conexion.Open()

                consulta = "select d.idDirectorio,d.NombreCompañia,dp.nom_deptoS as depto,m.nom_mpioS as muni,d.Telefono, d.NombreContacto, d.Observacion, d.Correo, d.Departamento, d.Municipio  from directorio d left join departamentos dp on d.Departamento = dp.id_deptoS left join municipios m on d.Municipio= m.id_mpioS where  dp.nemonico_deptoS='" & nemonico & "';"
                Dim cmd As New MySqlCommand(consulta, conexion)
                Dim reader As MySqlDataReader = cmd.ExecuteReader
                While reader.Read
                    Dim elemento As New ClassDirectorioDescripcion
                    With elemento


                        If Not IsDBNull(reader("idDirectorio")) Then
                            .IdDirectorio = reader("idDirectorio")
                        Else
                            .IdDirectorio = 0
                        End If
                        If Not IsDBNull(reader("NombreCompañia")) Then
                            .NombreCompania = reader("NombreCompañia")
                        Else
                            .NombreCompania = ""
                        End If
                        If Not IsDBNull(reader("depto")) Then
                            .NombreDepartamento = reader("depto")
                        Else
                            .NombreDepartamento = ""
                        End If

                        If Not IsDBNull(reader("muni")) Then
                            .NombreMunicipio = reader("muni")
                        Else
                            .NombreMunicipio = ""
                        End If

                        If Not IsDBNull(reader("Telefono")) Then
                            .Telefono = reader("Telefono")
                        Else
                            .Telefono = ""
                        End If

                        If Not IsDBNull(reader("NombreContacto")) Then
                            .Contacto = reader("NombreContacto")
                        Else
                            .Contacto = ""
                        End If

                        If Not IsDBNull(reader("Observacion")) Then
                            .Observacion = reader("Observacion")
                        Else
                            .Observacion = ""
                        End If

                        If Not IsDBNull(reader("Departamento")) Then
                            .idDepto = reader("Departamento")
                        Else
                            .idDepto = ""
                        End If

                        If Not IsDBNull(reader("Municipio")) Then
                            .idMunicipio = reader("Municipio")
                        Else
                            .idMunicipio = ""
                        End If

                        If Not IsDBNull(reader("Correo")) Then
                            .Correo = reader("Correo")
                        Else
                            .Correo = ""
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