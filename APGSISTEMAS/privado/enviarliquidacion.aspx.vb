Imports Microsoft.VisualBasic
Imports System.Data
Imports MySql.Data.MySqlClient
Partial Class privado_enviarliquidacion
    Inherits System.Web.UI.Page
    Dim page As Integer = 2002
    Dim datos As New datos()

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
    Sub llenagrid()
        Dim conexion As New datos
        Dim cadena As String
        Dim user, consu As String
        Dim dt, dt2 As DataTable
        Dim total As Double
        Dim totalfact As Double
        Dim dr As DataRow
        total = 0.0
        user = Request.Cookies("UserSettings")("user")
        cadena = "select date_format(F.fecha, '%d-%m-%Y') as fecha, F.serie, F.nofac, P.nombre, F.provedor from dbtransgentrac.facturacion F join dbtransgentrac.proveedores P on F.provedor = P.nit where F.usuario = '" & user & "' and liquidado='0'"
        'conexion.cargar_Grid(Detalle, cadena)
        dt = datos.cargar_datatable(cadena)
        dt.Columns.Add(New DataColumn("Valor", GetType(String)))
        If dt.Rows.Count > 0 Then
            For i As Integer = 0 To dt.Rows.Count - 1
                consu = "select sum(total) as suma from facturaciond where usuario='" & user & "' and serie_fac='" & dt.Rows(i).Item("serie") & "' and num_fac = '" & dt.Rows(i).Item("nofac") & "'"
                dt2 = conexion.Datos(consu)
                totalfact = dt2.Rows(0).Item("suma")
                total = total + totalfact
                dt.Rows(i).Item("Valor") = totalfact
                'dr = dt.NewRow()
                'dr("Valor") = totalfact
                'dt.Rows.Add(dr)
            Next
        End If

        txttotalgastos.Value = Format(total, "##,##0.00")
        'txttotalgastos.Value = total
        Detalle.DataSource = dt
        Detalle.DataBind()
    End Sub

    Protected Sub btnenviar_ServerClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnenviar.ServerClick
        Try
            Dim MyDB As New MyDB
            Dim serie, numero, proveedor, nit, total As String
            Dim corre, fecha, usuario, gastos, cargo, favor, anticipo, str, str1 As String
            Dim dt2, dt3 As DataTable
            If txtamtocipos.Value <> "" Then
                usuario = Request.Cookies("UserSettings")("user")
                corre = TxtSerieFactura.Value
                fecha = Date.Today.Year & "-" & Date.Today.Month & "-" & Date.Today.Day
                gastos = txttotalgastos.Value.Replace(",", "")
                cargo = Text3.Value
                favor = txtsaldofavor.Value
                anticipo = txtamtocipos.Value
                str = "insert into Liquidacion(usuario,fecha,anticipo,totalgastos,saldocargo,saldofavor,correlativo) values('" & usuario & "', '" & fecha & "', " & anticipo & ", " & gastos & ", " & cargo & ", " & favor & ", " & corre & ")"
                If MyDB.MyCommand(str)Then
                    If Detalle.Rows.Count > 0 Then
                        For i As Integer = 0 To Detalle.Rows.Count - 1
                            Dim newdate As DateTime = Date.Parse(Detalle.Rows(i).Cells(0).Text, System.Globalization.CultureInfo.CreateSpecificCulture("en-au"))
                            Dim fec = Year(newdate) & "/" & Month(newdate) & "/" & Day(newdate)
                            serie = Detalle.Rows(i).Cells(1).Text
                            numero = Detalle.Rows(i).Cells(2).Text
                            proveedor = Detalle.Rows(i).Cells(3).Text
                            nit = Detalle.Rows(i).Cells(4).Text
                            total = Detalle.Rows(i).Cells(5).Text

                            dt3 = MyDB.MySelect("select idliquidacion as id, correlativo from liquidacion where usuario='" & usuario & "' and correlativo =  " & corre & "")
                            Dim a = "select corre from facturacion where usuario='" & usuario & "' and serie='" & serie & "' and nofac=" & numero & " and provedor='" & nit & "'"
                            If nit = "&nbsp;" Then
                                nit = ""


                            End If
                            dt2 = MyDB.MySelect("select corre from facturacion where usuario='" & usuario & "' and serie='" & serie & "' and nofac=" & numero & " and provedor='" & nit & "'")

                            str = "insert into LiquidacionDetalle(idliquidacion,correlativo,idfactura,totalfact) values(" & dt3.Rows(0).Item("id") & "," & dt3.Rows(0).Item("correlativo") & ", '" & dt2.Rows(0).Item("corre") & "', " & total & ")"
                            str1 = "update facturacion set liquidado= true where usuario='" & usuario & "' and serie='" & serie & "' and nofac=" & numero & " and provedor='" & nit & "'"
                            datos.EjecutaTransaccion(str, str1)
                        Next
                        txtamtocipos.Value = ""
                        txtsaldofavor.Value = ""
                        Text3.Value = ""
                    End If
                End If
                CORRELATIVO()
                llenagrid()
            End If
        Catch ex As Exception
            'MsgBox(ex.Message)
        End Try
    End Sub

    Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        Dim user, consu, corre As String
        Dim dt, dt2 As DataTable
        Dim conexion As New datos

        If Not datos.acceso(Request.Cookies("UserSettings")("user"), page) Then
            Response.Redirect("403")
        End If
        infoMenu()
        llenagrid()
        TxtFecha.Value = Date.Today
        CORRELATIVO()
    End Sub
    Sub CORRELATIVO()
        Dim user, consu, corre As String
        Dim dt, dt2 As DataTable
        Dim conexion As New datos
        User = Request.Cookies("UserSettings")("user")
        consu = "select max(correlativo) as corr from Liquidacion where usuario='" & User & "'"
        dt2 = conexion.Datos(consu)
        If dt2.Rows(0).Item("corr").ToString = "" Then
            corre = 1
        Else
            corre = dt2.Rows(0).Item("corr") + 1
        End If
        TxtSerieFactura.Value = corre
    End Sub
End Class
