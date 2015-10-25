Imports Microsoft.Office.Interop.Excel
Imports System.Text
Imports System.Reflection
Imports System.Data
Imports System.Web
Imports MySql.Data.MySqlClient
Partial Class privado_cargarfacturasversatec
    Inherits System.Web.UI.Page
    Dim page As Integer = 10001
    Dim datos As New datos()
    Dim conexion As MySqlConnection

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), page) Then
            Response.Redirect("403")
        End If
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
    Protected Sub BtnCargarFactura_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnCargarFactura.Click
        Dim files As HttpFileCollection = Request.Files
        Dim postedFile As HttpPostedFile = files(0)
        Dim nbr = postedFile.FileName.ToString
        Dim extencion As Array = Split(nbr, ".")
        Dim path As String = "~/privado/facturaxlsx/" & Now.Year.ToString & "_" & Now.Month.ToString & "_" & datos.StringAleatoreo(15) & "." & extencion(extencion.Length - 1)
        CargarExcel.SaveAs(Server.MapPath(path))
        Dim ds As DataSet = GetExcel(Server.MapPath(path))
        Dim dt As System.Data.DataTable = ds.Tables(0)
        If dt.Rows.Count > 0 Then
            Using conexion As New MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Conn").ConnectionString)
                conexion.Open()
                Dim comando As MySqlCommand
                comando = conexion.CreateCommand
                comando.CommandType = Data.CommandType.Text
                Dim transaccion As MySqlTransaction = conexion.BeginTransaction
                comando.Transaction = transaccion
                Try
                    For i As Integer = 0 To dt.Rows.Count - 1
                        Dim consulta As String = "select id,npiloto,departamento, count(id) count from _vehiculos where placa='" & dt.Rows(i).Item(0) & "' limit 1"
                        Dim cmd As New MySqlCommand(consulta, conexion)
                        Dim reader As MySqlDataReader = cmd.ExecuteReader()
                        Dim Vehiculo As Integer = 0
                        Dim piloto As Integer = 0
                        Dim departamento As Integer = 0
                        Dim count As Integer = 0
                        While reader.Read
                            count = reader("count")
                            If count > 0 Then
                                Vehiculo = reader("id")
                                piloto = reader("npiloto")
                                departamento = reader("departamento")
                            End If
                        End While
                        reader.Close()
                        If count > 0 Then
                            Dim InsertEncabezado As String = "INSERT INTO facturacion (fecha, Vehiculo, serie, nofac,provedor,departamento, usuario, comprador, recibe, tipo_fac, genera_iva, descuento, status, nempresa, tipo_doc,retencion, tipo_pago) " _
                                                                                  + "VALUES('" & dt.Rows(i).Item(1) & "', " & Vehiculo & ", '" & dt.Rows(i).Item(3) & "', '" & dt.Rows(i).Item(2) & "','000000-0'," & departamento & ",'" & Request.Cookies("UserSettings")("user") & "'," & piloto & "," & piloto & ",1,1,0,1,1,1,'NO',1);"
                            comando.CommandText = InsertEncabezado
                            comando.ExecuteNonQuery()
                            comando.CommandText = "SELECT @@IDENTITY"
                            Dim correlativo As Integer = comando.ExecuteScalar
                            'MsgBox(dt.Rows(i).Item(0))
                            Dim InsertDetalle As String = "INSERT INTO facturaciond (codigo,precioU,cantidad,total, correlativo, nit_proveedor,serie_fac,num_fac, Estado, CargaInventario,usuario) " _
                                                            + "VALUES('" & dt.Rows(i).Item(6) & "', '" & Val(dt.Rows(i).Item(5)) & "', '" & Val(dt.Rows(i).Item(4)) & "','" & Val(dt.Rows(i).Item(5)) * Val(dt.Rows(i).Item(4)) & "'," & correlativo & ",'000000-0', '" & dt.Rows(i).Item(3) & "', '" & dt.Rows(i).Item(2) & "',1,1,'" & Request.Cookies("UserSettings")("user") & "');"
                            comando.CommandText = InsertDetalle
                            comando.ExecuteNonQuery()
                        End If
                    Next
                    transaccion.Commit()
                Catch ex As Exception
                    ScriptManager.RegisterStartupScript(BtnCargarFactura, GetType(Page), "Alerta", "alert('" & ex.Message & "');", True)
                    'MsgBox(ex.Message)
                    transaccion.Rollback()
                Finally
                    conexion.Close()
                End Try

            End Using
        End If
        'GridView1.DataSource = ds
        'GridView1.DataBind()
    End Sub
    Public Function GetExcel(ByVal fileName As String) As DataSet
        Dim oXL As Application
        Dim oWB As Workbook
        Dim oSheet As Worksheet
        Dim oRng As Range
        Try
            '  creat a Application object
            oXL = New ApplicationClass()
            '   get   WorkBook  object
            oWB = oXL.Workbooks.Open(fileName, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
             Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, Missing.Value, _
             Missing.Value, Missing.Value, Missing.Value)


            '   get   WorkSheet object
            oSheet = DirectCast(oWB.Sheets(1), Microsoft.Office.Interop.Excel.Worksheet)
            For Each ws As Worksheet In oWB.Sheets
            Next
            Dim dt As New System.Data.DataTable("dtExcel")
            Dim ds As New DataSet()
            ds.Tables.Add(dt)
            Dim dr As DataRow


            Dim sb As New StringBuilder()
            Dim jValue As Integer = oSheet.UsedRange.Cells.Columns.Count
            Dim iValue As Integer = oSheet.UsedRange.Cells.Rows.Count
            '  get data columns
            Dim j1 As Integer = 1
            While j1 <= jValue
                dt.Columns.Add("column" & j1, System.Type.GetType("System.String"))
                System.Math.Max(System.Threading.Interlocked.Increment(j1), j1 - 1)
            End While


            'string colString = sb.ToString().Trim();
            'string[] colArray = colString.Split(':');


            '  get data in cell
            Dim i As Integer = 1
            While i <= iValue
                dr = ds.Tables("dtExcel").NewRow()
                Dim j As Integer = 1
                While j <= jValue
                    oRng = DirectCast(oSheet.Cells(i, j), Microsoft.Office.Interop.Excel.Range)
                    Dim strValue As String = oRng.Text.ToString()
                    dr("column" & j) = strValue
                    System.Math.Max(System.Threading.Interlocked.Increment(j), j - 1)
                End While
                ds.Tables("dtExcel").Rows.Add(dr)
                System.Math.Max(System.Threading.Interlocked.Increment(i), i - 1)
            End While
            Return ds
        Catch ex As Exception
            'MsgBox(ex.Message)
            Return Nothing
        Finally
            Dispose()
        End Try
    End Function
End Class
