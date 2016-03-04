Imports iTextSharp.text
Imports System.Data
Imports System.Web.Services
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Generic
Imports System.IO
Imports System
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html
Imports iTextSharp.text.html.simpleparser
Imports Microsoft.VisualBasic
Imports MySql.Data.MySqlClient
Partial Class privado_liquidaciones
    Inherits System.Web.UI.Page
    Dim page As Integer = 2003
    Dim datos As New datos()
    Dim MyDB As MyDB
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not datos.acceso(Request.Cookies("UserSettings")("user"), page) Then
            Response.Redirect("403")
        End If
        infoMenu()
    End Sub
    Sub infoMenu()
        LblUsuario.Text = Request.Cookies("UserSettings")("user")
        LblUser.Text = Request.Cookies("UserSettings")("user")
        ImagenMenu.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
        ImagenUsuario.ImageUrl = "images/perfil/" & Request.Cookies("UserSettings")("Imagen")
    End Sub

    Protected Sub DescargarPDF_ServerClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles DescargarPDF.ServerClick
        Try
            Dim Cn As New datos
            Dim dt, dt2, dt3, dt4, dt5, dt1 As DataTable
            Dim codigo As String

            codigo = "select L.*, pu.descripcion,p.nombre from dbtransgentrac.liquidacion L join dbtransgentrac.userw U on L.usuario = U.username join dbtransgentrac.personal p on p.idempleado = u.idpersonal join dbtransgentrac.departamentos pu on pu.id = p.idArea where L.idliquidacion = '" & Session("IdLiquidacion") & "'"
            dt = Cn.Datos(codigo)

            codigo = "SELECT distinct idfactura FROM liquidaciondetalle where idliquidacion = '" & Session("IdLiquidacion") & "'"
            dt2 = Cn.Datos(codigo)

            codigo = "select concat(day(max(F.fecha)), '/', month(max(F.fecha)), '/',year(max(F.fecha))) as fechafinal, concat(day(min(F.fecha)), '/', month(min(F.fecha)), '/',year(min(F.fecha))) as fechainicio from dbtransgentrac.liquidaciondetalle L join dbtransgentrac.facturacion F on L.idfactura = F.corre where L.idliquidacion = '" & Session("IdLiquidacion") & "'"
            dt5 = Cn.Datos(codigo)

            If dt.Rows.Count > 0 Then
                Response.ContentType = "application/pdf"
                Response.AddHeader("content-disposition",
                "attachment;filename=GridViewExport.pdf")
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                Dim sw As New StringWriter()
                Dim hw As New HtmlTextWriter(sw)
                Dim image, image2 As iTextSharp.text.Image
                Dim parrafo As New Paragraph
                'conexion = Replace(Date.Now.ToString, "/", "-").Replace(" ", "-").Replace(":", "-").Replace(".", "-")
                'style to format numbers to string
                Dim style As String = "<style>.textmode{mso-number-format:\@;}</style>"
                Response.Write(style)
                Dim sr As New StringReader(sw.ToString())

                Dim pdfDoc As New Document(PageSize.LETTER, 30.0F, 20.0F, 90.0F, 10.0F)
                Dim htmlparser As New HTMLWorker(pdfDoc)
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream)

                If pdfDoc.IsOpen Then
                    pdfDoc.Close()
                End If

                Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, New FileStream(Request.PhysicalApplicationPath + "\privado\Liquidaciones\Liquidacion" & "-" & dt.Rows(0).Item("usuario") & "-" & dt.Rows(0).Item("correlativo") & ".pdf", FileMode.Create))
                pdfDoc.Open()
                image2 = iTextSharp.text.Image.GetInstance(Server.MapPath("~/images/logoGentrac.jpg")) 'Dirección a la imagen que se hace referencia
                image2.SetAbsolutePosition(60, 700) 'Posición en el eje cartesiano
                image2.ScaleAbsoluteWidth(175) 'Ancho de la imagen
                image2.ScaleAbsoluteHeight(60) 'Altura de la imagen
                pdfDoc.Add(image2) ' Agrega la imagen al documento
                'End If

                Dim table As New PdfPTable(4)
                Dim incrustada As New PdfPTable(3)
                Dim cell As PdfPCell
                Dim widths As Integer()
                Dim fuente As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.NORMAL, Color.WHITE)
                Dim fuente2 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.NORMAL, Color.BLACK)
                Dim fuente3 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.NORMAL, Color.BLUE)
                Dim fuente4 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 12.0F, iTextSharp.text.Font.NORMAL, Color.GRAY)
                Dim fuente5 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 11.0F, iTextSharp.text.Font.BOLD, Color.BLACK)
                Dim fuente6 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 9.0F, iTextSharp.text.Font.BOLD, Color.BLACK)

                table = New PdfPTable(4)
                widths = New Integer() {2.0F, 2.0F, 2.0F, 2.0F}
                table.SetWidths(widths)
                table.HorizontalAlignment = 1
                table.WidthPercentage = 100
                table.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("DEPTO.", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt.Rows(0).Item("DESCRIPCION").ToString, fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Efectuado por:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt.Rows(0).Item("nombre").ToString, fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Correspondiente al periodo del:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt5.Rows(0).Item("fechainicio") & "  al  " & dt5.Rows(0).Item("fechafinal"), fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                pdfDoc.Add(table)

                table = New PdfPTable(9)
                widths = New Integer() {1.0F, 1.0F, 1.0F, 1.0F, 1.0F, 1.0F, 2.0F, 2.0F, 1.0F}
                table.SetWidths(widths)
                table.HorizontalAlignment = 0
                table.WidthPercentage = 100
                table.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("Fecha", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthLeft = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("LUGAR O.T.No.", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Serie", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Numero", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Proveedor", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Nit", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Descripcion:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Observacion:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Total", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                cell.BorderWidthTop = 1
                cell.BorderWidthBottom = 1
                cell.BorderWidthRight = 1
                table.AddCell(cell)

                If dt2.Rows.Count > 0 Then
                    For i As Integer = 0 To dt2.Rows.Count - 1
                        Dim StringDetalle As String = ""
                        codigo = "select F.*, p.nombre from facturacion f join proveedores p on p.nit= f.provedor where f.corre = '" & dt2.Rows(i).Item("idFactura") & "'"
                        dt3 = Cn.Datos(codigo)

                        codigo = "select sum(total) as total from facturaciond where correlativo= '" & dt2.Rows(i).Item("idFactura") & "'"
                        dt4 = Cn.Datos(codigo)

                        codigo = "select i.descripcion from facturaciond fd inner join inventario i on fd.codigo=i.codigo where correlativo=" & dt2.Rows(i).Item("idFactura") & ""
                        dt1 = Cn.Datos(codigo)

                        For j As Integer = 0 To dt1.Rows.Count - 1
                            If StringDetalle = "" Then
                                StringDetalle = dt1.Rows(j).Item("descripcion")
                            Else
                                StringDetalle = StringDetalle & ", " & dt1.Rows(j).Item("descripcion")
                            End If
                        Next

                        cell = New PdfPCell(New Phrase(dt3.Rows(0).Item("fecha"), fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 1
                        cell.BorderWidthLeft = 1
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(dt3.Rows(0).Item("ordentrabajo"), fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(dt3.Rows(0).Item("serie"), fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(dt3.Rows(0).Item("nofac"), fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(dt3.Rows(0).Item("nombre"), fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(dt3.Rows(0).Item("provedor"), fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(StringDetalle, fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(dt3.Rows(0).Item("descrip").ToString, fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(Format(dt4.Rows(0).Item("total"), "#,###,##0.00"), fuente2))
                        'cell.BackgroundColor = New Color(24, 34, 133)
                        cell.BorderWidth = 0
                        cell.HorizontalAlignment = 2
                        cell.BorderWidthRight = 1
                        table.AddCell(cell)
                    Next
                End If
                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                cell.BorderWidthTop = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                cell.BorderWidthTop = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.BorderWidthTop = 1
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.BorderWidthTop = 1
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.BorderWidthTop = 1
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.BorderWidthTop = 1
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.BorderWidthTop = 1
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.BorderWidthTop = 1
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.BorderWidthTop = 1
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("ANTICIPOS", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(Format(dt.Rows(0).Item("anticipo"), "#,###,##0.00"), fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 1
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)


                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("TOTAL GASTOS", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(Format(dt.Rows(0).Item("TOTALGASTOS"), "#,###,##0.00"), fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 1
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("SALDO A CARGO", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(Format(dt.Rows(0).Item("saldocargo"), "#,###,##0.00"), fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 1
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("SALDO A FAVOR", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(Format(dt.Rows(0).Item("saldofavor"), "#,###,##0.00"), fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 1
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)
                pdfDoc.Add(table)

                Dim trabajo As New PdfPTable(3)
                widths = New Integer() {3.0F, 3.0F, 3.0F}
                trabajo.SetWidths(widths)
                trabajo.WidthPercentage = 100
                trabajo.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("", fuente2))
                cell.BorderWidth = 0
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente2))
                cell.BorderWidth = 0
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente2))
                cell.BorderWidth = 0
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("_________________________", fuente2))
                cell.BorderWidth = 0
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("_________________________", fuente2))
                cell.BorderWidth = 0
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("_________________________", fuente2))
                cell.BorderWidth = 0
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("Jefe del Depto", fuente2))
                cell.BorderWidth = 0
                cell.FixedHeight = 15
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("Firma del Empleado", fuente2))
                cell.BorderWidth = 0
                cell.FixedHeight = 15
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("GENTRAC", fuente2))
                cell.BorderWidth = 0
                cell.FixedHeight = 15
                cell.Colspan = 1
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)
                pdfDoc.Add(trabajo)

                pdfDoc.Close()
                'Response.Redirect("~/privado/Liquidaciones/Liquidacion" & "-" & dt.Rows(0).Item("usuario") & "-" & dt.Rows(0).Item("correlativo") & ".pdf")
                'Response.Write(pdfDoc)
                'Response.End()

                Dim Archivo = Trim("Liquidacion" & "-" & dt.Rows(0).Item("usuario") & "-" & dt.Rows(0).Item("correlativo") & ".pdf")
                Dim Ruta As String = Server.MapPath("~/privado/Liquidaciones/")
                Response.ClearHeaders()
                Response.ClearContent()
                Response.ContentType = "application/pdf"
                Dim DatoArchivo As String = "attachment; filename=" + Archivo
                Response.AddHeader("content-disposition", DatoArchivo)
                Dim rutaCompleta As String = Ruta + Archivo
                rutaCompleta = Replace(rutaCompleta, "\", "/")

                Response.WriteFile(rutaCompleta)
                'Response.End()
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
End Class