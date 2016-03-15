Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols

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
    Public Function GuardarDirectorio(ByVal NombreCompania As String, ByVal Direccion As String, ByVal Departamento As String, ByVal Municipio As String, ByVal Telefono As String, ByVal NombreContacto As String, ByVal Observacion As String,ByVal Correo as String) As List(Of ClassGuardarCliente)
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


End Class