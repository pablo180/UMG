Partial Class privado_Productos
    Inherits System.Web.UI.Page
    Dim datos As New datos
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        datos.CargarComboMas(DropProveedor, "SELECT IdCliente, Nombre FROM proveedor;", 0)
        datos.CargarComboMas(DropDUnidad, "Select idUnidad, descripcion FROM unidad;", 0)
        datos.CargarComboMas(DropCategoria, "SELECT idCategorias, descripcion FROM categorias;",0)






    End Sub

End Class
