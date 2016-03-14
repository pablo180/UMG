Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Microsoft.VisualBasic
Imports System.Data
' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente.
<System.Web.Script.Services.ScriptService()>
<WebService(Namespace:="http://tempuri.org/")>
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Public Class wsdepartamentomunicipio
    Inherits System.Web.Services.WebService
    Dim MyDB As New MyDB
    Class Departamento
        Public IdDepartamento As Integer
        Public Nombre As String
        Public IdDepartamento1 As Integer
        Public Nombre1 As String
    End Class
    Class Municipio
        Public IdMunicipio As Integer
        Public Nombre As String
    End Class
    <WebMethod()>
    Public Function DepartamentoOpcion() As List(Of Departamento)
        Dim result As New List(Of Departamento)
        Dim ListarDepartamento As DataTable = MyDB.MySelect("select sisId, sisDescripcion from empresadepartamento;")
        For Each row As DataRow In ListarDepartamento.Rows
            Dim elemento As New Departamento
            elemento.IdDepartamento1 = row("sisId")
            elemento.Nombre1 = row("sisDescripcion")
            result.Add(elemento)
        Next
        Return result
    End Function
    <WebMethod()>
    Public Function Departamentos() As List(Of Departamento)
        Dim result As New List(Of Departamento)
        Dim ListarDepartamento As DataTable = MyDB.MySelect("select id_deptoS, nom_deptoS from departamentos;")
        For Each row As DataRow In ListarDepartamento.Rows
            Dim elemento As New Departamento
            elemento.IdDepartamento = row("id_deptoS")
            elemento.Nombre = row("nom_deptoS")
            result.Add(elemento)
        Next
        Return result
    End Function

    <WebMethod()>
    Public Function Municipios(ByVal IdDepartamento As Integer) As List(Of Municipio)
        Dim result As New List(Of Municipio)
        Dim ListarMunicipios As DataTable
        If IdDepartamento = 0 Then
            ListarMunicipios = MyDB.MySelect("select id_mpioS, nom_mpioS from municipios;")
        Else
            ListarMunicipios = MyDB.MySelect("select id_mpioS, nom_mpioS from municipios where id_deptoS=" & IdDepartamento)
        End If
        For Each row As DataRow In ListarMunicipios.Rows
            Dim elemento As New Municipio
            elemento.IdMunicipio = row("id_mpioS")
            elemento.Nombre = row("nom_mpioS")
            result.Add(elemento)
        Next
        Return result
    End Function

End Class