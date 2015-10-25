Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_ReporteLL
    Inherits System.Web.UI.Page
    Dim datos As New datos()
    Dim idLiquidacion As Integer
    Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        Dim user, consu, corre As String
        Dim conexion As New datos

        datos.CargarCombo(DropDepartamentos, "select id, descripcion from departamentos")

    End Sub
End Class
