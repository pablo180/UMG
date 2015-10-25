Imports System.Data
Imports System.Web.Services
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Generic
Imports System.IO
Imports System
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html
Imports iTextSharp.text.html.simpleparser
Imports ClosedXML
Imports ClosedXML.Excel
Imports DocumentFormat
Imports DocumentFormat.OpenXml

Partial Class privado_liquidacionpdf
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim user As String
        User = Request.Cookies("UserSettings")("user")

        Try
            Dim dt, dt2, dt3, dt4 As DataTable
            Dim cn As New datos
            Dim fecha As Date
            Dim codigo, dir, conexion As String
            Dim subt As Double = 0.0
            Dim desc As Double = 0.0
            Dim tot As Double = 0.0
            conexion = Replace(Date.Now.ToString, "/", "-").Replace(" ", "-").Replace(":", "-").Replace(".", "-")

            dir = Session("direEmpsa") & " PBX: " & Session("telEmpsa")
            Dim id_encar As Integer
            Dim sin_desc_deta As Double
            codigo = "select TEC.Recargo_Cotizacion AS Rec,TEC.no_recepcion as RECEPCION,TEC.Id_Enc_Cotizacion as NO_COT, TEC.fecha_cotizacion as FECHA, tec.Contacto_Cotizacion " & _
                    "as NOMBRE, TC.Nom_clt as EMPRESA, TC.Dire_Clt AS DIRECCION, TC.Tel_Clt AS TELEFONO, TEC.Descuento_Cotizacion as Descuento_C, " & _
                    "TC.Correo_Clt AS CORREO_E, TEC.Des_Cotizacion AS OBSERVACIONES, TEC.Forma_Pago_Cotizacion AS FORMA_P, " & _
                    "TEC.Tiempo_Entrega_Cotizacion AS TIEMPO_E, TEC.Total_Cotizacion AS TOTAL, TEC.Sin_Descuento_Cotizacion as SIN_DESC,id_encargado " & _
                    "from TJR_Enc_Cotizacion as TEC inner join TJR_CLiente as TC on TC.Id_Clt = TEC.Id_Clt where id_enc_cotizacion = '" & Session("Correlativo") & "' and Id_Empsa ='" & Session("Empresa") & "'"
            dt = cn.Datos(codigo)
            If dt.Rows.Count > 0 Then
                id_encar = dt.Rows(0).Item("id_encargado")

                Response.ContentType = "application/pdf"
                Response.AddHeader("content-disposition",
                "attachment;filename=GridViewExport.pdf")
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                Dim sw As New StringWriter()
                Dim hw As New HtmlTextWriter(sw)
                Dim image, image2 As iTextSharp.text.Image
                Dim parrafo As New Paragraph

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
                Dim writer As PdfWriter = PdfWriter.GetInstance(pdfDoc, New FileStream(Request.PhysicalApplicationPath + "\reporte\Cotizacion" & conexion & ".pdf", FileMode.Create))
                'Dim footer As New HeaderFooter(New Phrase(dir, New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.NORMAL, Color.GRAY)), False)
                'pdfDoc.Footer = footer
                'writer.PageEvent = New Handler()
                pdfDoc.Open()


                If Session("Logo") <> "" And Session("logo") <> "pendiente" Then
                    image = iTextSharp.text.Image.GetInstance(Server.MapPath("~/images/" & Session("Logo") & ".png")) 'Dirección a la imagen que se hace referencia
                    image.SetAbsolutePosition(450, 715) 'Posición en el eje cartesiano
                    image.ScaleAbsoluteWidth(150) 'Ancho de la imagen
                    image.ScaleAbsoluteHeight(50) 'Altura de la imagen
                    pdfDoc.Add(image) ' Agrega la imagen al documento

                    image2 = iTextSharp.text.Image.GetInstance(Server.MapPath("~/images/logo_taller1.png")) 'Dirección a la imagen que se hace referencia
                    image2.SetAbsolutePosition(50, 715) 'Posición en el eje cartesiano
                    image2.ScaleAbsoluteWidth(60) 'Ancho de la imagen
                    image2.ScaleAbsoluteHeight(60) 'Altura de la imagen
                    pdfDoc.Add(image2) ' Agrega la imagen al documento
                End If

                Dim table As New PdfPTable(4)
                Dim incrustada As New PdfPTable(3)
                Dim cell As PdfPCell
                Dim widths As Integer()
                Dim fuente As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.NORMAL, Color.WHITE)
                Dim fuente2 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.NORMAL, Color.BLACK)
                Dim fuente3 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.NORMAL, Color.BLUE)
                Dim fuente4 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 12.0F, iTextSharp.text.Font.NORMAL, Color.GRAY)
                Dim fuente5 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 11.0F, iTextSharp.text.Font.BOLD, Color.BLACK)
                Dim fuente6 As New iTextSharp.text.Font(iTextSharp.text.Font.HELVETICA, 8.0F, iTextSharp.text.Font.BOLD, Color.BLACK)

                table = New PdfPTable(2)
                widths = New Integer() {1.0F, 1.0F}
                table.SetWidths(widths)
                table.HorizontalAlignment = 2
                table.WidthPercentage = 30
                table.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("Forma de Pago", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt.Rows(0).Item("FORMA_P").ToString, fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 1
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Tiempo de Entrega", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 2
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt.Rows(0).Item("TIEMPO_E").ToString, fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 1
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                pdfDoc.Add(table)

                table = New PdfPTable(2)
                widths = New Integer() {1.0F, 3.0F}
                table.SetWidths(widths)
                table.HorizontalAlignment = 0
                table.WidthPercentage = 50
                table.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("Cotización:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt.Rows(0).Item("NO_COT").ToString, fuente3))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Cliente:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt.Rows(0).Item("EMPRESA").ToString, fuente3))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Solicitante:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(dt.Rows(0).Item("NOMBRE").ToString, fuente3))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Asunto:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Cotización", fuente3))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase("Fecha:", fuente6))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                cell = New PdfPCell(New Phrase(Day(dt.Rows(0).Item("FECHA").ToString) & "/" & Month(dt.Rows(0).Item("FECHA").ToString) & "/" & Year(dt.Rows(0).Item("FECHA").ToString), fuente3))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                pdfDoc.Add(table)

                Dim recepcionm As New PdfPTable(8)
                widths = New Integer() {1.0F, 1.0F, 1.0F, 1.0F, 1.0F, 1.0F, 1.0F, 1.0F}
                recepcionm.SetWidths(widths)
                recepcionm.WidthPercentage = 100
                recepcionm.SpacingBefore = 15
                Dim tarea, hp, volt, amp, rpm, equipo, hz, polos, marca, ht, hr, hrq, area, fechaing, controlrep, tipot, falla As String
                codigo = "select r.*, c.nom_clt,Representante_Clt as contacto,Tel_Clt from tjr_recepcion as r inner join tjr_cliente as c on " & _
                "c.id_clt = r.id_clt where no_recepcion = '" & dt.Rows(0).Item("recepcion").ToString & "'"
                dt3 = cn.Datos(codigo)

                If dt3.Rows.Count = 0 Then
                    tarea = Session("trabajo")
                    hp = "0"
                    volt = "0"
                    amp = "0"
                    rpm = "0"
                    equipo = "0"
                    hz = "0"
                    polos = "0"
                    marca = "0"
                    ht = "0"
                    hr = "0"
                    hrq = "0"
                    area = "0"
                    fechaing = "0"
                    controlrep = "0"
                    tipot = "0"
                    falla = "0"
                Else
                    tarea = dt3.Rows(0).Item("tarea").ToString
                    hp = dt3.Rows(0).Item("Caballos_Fuerza").ToString
                    volt = dt3.Rows(0).Item("Volt").ToString
                    amp = dt3.Rows(0).Item("ampe").ToString
                    rpm = dt3.Rows(0).Item("rpm").ToString
                    equipo = dt3.Rows(0).Item("Tipo_Maquina").ToString
                    hz = dt3.Rows(0).Item("Hz").ToString
                    polos = dt3.Rows(0).Item("Polos").ToString
                    marca = dt3.Rows(0).Item("marca").ToString
                    ht = dt3.Rows(0).Item("hoja_tecnica").ToString
                    hr = dt3.Rows(0).Item("no_recepcion").ToString
                    hrq = dt.Rows(0).Item("NO_COT").ToString
                    area = dt3.Rows(0).Item("funcion").ToString
                    fechaing = Day(dt3.Rows(0).Item("fecha_recepcion").ToString) & "/" & Month(dt3.Rows(0).Item("fecha_recepcion").ToString) & "/" & Year(dt3.Rows(0).Item("fecha_recepcion").ToString)
                    controlrep = "0"
                    tipot = dt3.Rows(0).Item("prioridad").ToString
                    falla = dt3.Rows(0).Item("falla").ToString

                    cell = New PdfPCell(New Phrase(tarea, fuente5))
                    cell.BorderWidth = 0
                    cell.Colspan = 15
                    cell.HorizontalAlignment = 1
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("", fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 15
                    cell.HorizontalAlignment = 1
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("HP: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.BorderWidthLeft = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(hp, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Equipo: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(equipo, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("HT: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(ht, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Fecha Ing.: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(fechaing, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthTop = 1
                    cell.BorderWidthRight = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("VOLT: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthLeft = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(volt, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("HZ: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(hz, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("HR: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(hr, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Control Rep.: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(controlrep, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthRight = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("AMP: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthLeft = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(amp, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Polos: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(polos, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("HRQ: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(hrq, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Tipo de T.: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(tipot, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthRight = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("RPM: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthLeft = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(rpm, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Marca: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(marca, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Area: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(area, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 3
                    cell.BorderWidthRight = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase("Falla o Problema: ", fuente6))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.BorderWidthLeft = 1
                    cell.BorderWidthBottom = 1
                    cell.HorizontalAlignment = 0
                    recepcionm.AddCell(cell)

                    cell = New PdfPCell(New Phrase(falla, fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 10
                    cell.BorderWidthBottom = 1
                    cell.BorderWidthRight = 1
                    cell.HorizontalAlignment = 0

                    recepcionm.AddCell(cell)
                    pdfDoc.Add(recepcionm)
                End If

                codigo = "select TDC.Recargo, TDC.descuento_deta_cotizacion as DES,TDC.Cant_Deta_Cotizacion as CANT, TDC.Observaciones_Deta_Cotizacion AS ART, TDC.Unidad_Medida_Deta_Cotizacion AS U_MEDIDA, " & _
                        "Alto_Deta_Cotizacion AS ALTO, Ancho_Deta_Cotizacion AS ANCHO,Fondo_Deta_Cotizacion AS FONDO, " & _
                        "TA.precio_unitario_art AS PRECIO_U,TDC.Precio_Deta_Cotizacion AS PRECIO_T, TDC.Descuento_Deta_Cotizacion as DESCUENTO " & _
                        "from TJR_Deta_Cotizacion as TDC inner join TJR_Articulo as TA on TA.Id_Art= TDC.Id_Art where id_enc_cotizacion =" & _
                        Val(dt.Rows(0).Item("No_Cot").ToString) & "and Id_Empsa ='" & Session("Empresa") & "'"
                dt2 = cn.Datos(codigo)

                If dt2.Rows.Count > 0 Then

                    table = New PdfPTable(6)
                    widths = New Integer() {2.0F, 7.0F, 2.0F, 2.0F, 2.0F, 2.0F}
                    table.SetWidths(widths)
                    table.WidthPercentage = 80
                    table.SpacingBefore = 15

                    cell = New PdfPCell(New Phrase("CANT.", fuente))
                    cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase("PRODUCTO", fuente))
                    cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase("PRECIO UNITARIO", fuente))
                    cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase("SUB-TOTAL", fuente))
                    cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase("DESCUENTO", fuente))
                    cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase("TOTAL", fuente))
                    cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    For i As Integer = 0 To dt2.Rows.Count - 1
                        cell = New PdfPCell(New Phrase(dt2.Rows(i).Item("CANT").ToString, fuente2))
                        If (Not (i Mod 2) = 0) And i > 0 Then
                            cell.BackgroundColor = New Color(155, 164, 252)
                        End If
                        cell.BorderWidth = 1
                        cell.HorizontalAlignment = 1
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(dt2.Rows(i).Item("ART").ToString, fuente2))
                        If (Not (i Mod 2) = 0) And i > 0 Then
                            cell.BackgroundColor = New Color(155, 164, 252)
                        End If
                        cell.BorderWidth = 1
                        cell.HorizontalAlignment = 0
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(Format((dt2.Rows(i).Item("PRECIO_U") + (dt2.Rows(i).Item("RECARGO") / dt2.Rows(i).Item("CANT"))), "Q #,###,##0.00"), fuente2))
                        If (Not (i Mod 2) = 0) And i > 0 Then
                            cell.BackgroundColor = New Color(155, 164, 252)
                        End If
                        cell.BorderWidth = 1
                        cell.HorizontalAlignment = 2
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(Format(((dt2.Rows(i).Item("PRECIO_U") * dt2.Rows(i).Item("CANT")) + dt2.Rows(i).Item("RECARGO")), "Q #,###,##0.00"), fuente2))
                        If (Not (i Mod 2) = 0) And i > 0 Then
                            cell.BackgroundColor = New Color(155, 164, 252)
                        End If
                        cell.BorderWidth = 1
                        cell.HorizontalAlignment = 2
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(Format(dt2.Rows(i).Item("DES"), "Q #,###,##0.00"), fuente2))
                        If (Not (i Mod 2) = 0) And i > 0 Then
                            cell.BackgroundColor = New Color(155, 164, 252)
                        End If
                        cell.BorderWidth = 1
                        cell.HorizontalAlignment = 2
                        table.AddCell(cell)

                        cell = New PdfPCell(New Phrase(Format(((dt2.Rows(i).Item("PRECIO_T") + dt2.Rows(i).Item("RECARGO")) - dt2.Rows(i).Item("DES")), "Q #,###,##0.00"), fuente2))
                        If (Not (i Mod 2) = 0) And i > 0 Then
                            cell.BackgroundColor = New Color(155, 164, 252)
                        End If
                        cell.BorderWidth = 1
                        cell.HorizontalAlignment = 2
                        table.AddCell(cell)
                    Next

                    cell = New PdfPCell(New Phrase("TOTAL", fuente6))
                    'cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
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
                    cell.HorizontalAlignment = 2
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase("", fuente6))
                    'cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 2
                    table.AddCell(cell)

                    cell = New PdfPCell(New Phrase(Format(dt.Rows(0).Item("TOTAL"), "Q #,###,##0.00"), fuente6))
                    'cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 2
                    table.AddCell(cell)

                    pdfDoc.Add(table)
                End If

                Dim trabajo As New PdfPTable(3)
                widths = New Integer() {2.0F, 4.0F, 2.0F}
                trabajo.SetWidths(widths)
                trabajo.WidthPercentage = 100
                trabajo.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("ALCANCE DEL SERVICIO", fuente5))
                cell.BorderWidth = 0
                cell.Colspan = 15
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                cell = New PdfPCell(New Phrase("", fuente2))
                cell.BorderWidth = 0
                cell.Colspan = 15
                cell.HorizontalAlignment = 1
                trabajo.AddCell(cell)

                Dim dt5 As DataTable
                If dt3.Rows.Count > 0 Then
                    dt5 = cn.Datos("select id,descri_trabajo from TJR_Trabajo_Realizar where trabajo_realizar = '" & dt3.Rows(0).Item("TAREA") & "'")
                ElseIf dt3.Rows.Count = 0 Then
                    dt5 = cn.Datos("select id,descri_trabajo from TJR_Trabajo_Realizar where trabajo_realizar = '" & Session("trabajo") & "'")
                End If

                codigo = "select detalle_trabajo from TJR_Trabajo_Realizar_Deta where id_trabajo = '" & dt5.Rows(0).Item("id") & "' and estado = 1"
                dt4 = cn.Datos(codigo)
                For i As Integer = 0 To dt4.Rows.Count - 1

                    cell = New PdfPCell(New Phrase("", fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 1
                    trabajo.AddCell(cell)

                    cell = New PdfPCell(New Phrase(dt4.Rows(i).Item("detalle_trabajo"), fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 0
                    trabajo.AddCell(cell)

                    cell = New PdfPCell(New Phrase("", fuente2))
                    cell.BorderWidth = 0
                    cell.Colspan = 1
                    cell.HorizontalAlignment = 1
                    trabajo.AddCell(cell)
                Next
                pdfDoc.Add(trabajo)

                table = New PdfPTable(1)
                widths = New Integer() {1.0F}
                table.SetWidths(widths)
                table.HorizontalAlignment = 0
                table.WidthPercentage = 100
                table.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("Observaciones", fuente5))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 0
                table.AddCell(cell)
                cell = New PdfPCell(New Phrase(dt5.Rows(0).Item("descri_trabajo").ToString, fuente2))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.Colspan = 3
                cell.HorizontalAlignment = 0
                table.AddCell(cell)

                pdfDoc.Add(table)

                table = New PdfPTable(1)
                widths = New Integer() {1.0F}
                table.SetWidths(widths)
                table.HorizontalAlignment = 0
                table.WidthPercentage = 100
                table.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("Órdenes de compra y cheques a nombre de " & Session("nomEmp") & "", fuente5))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)
                cell = New PdfPCell(New Phrase("Precio ya incluye iva", fuente5))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)

                pdfDoc.Add(table)

                table = New PdfPTable(1)
                widths = New Integer() {1.0F}
                table.SetWidths(widths)
                table.HorizontalAlignment = 0
                table.WidthPercentage = 100
                table.SpacingBefore = 15

                cell = New PdfPCell(New Phrase("Sin otro particular y en espera de una pronta respuesta, Atentamente:", fuente5))
                'cell.BackgroundColor = New Color(24, 34, 133)
                cell.BorderWidth = 0
                cell.HorizontalAlignment = 1
                table.AddCell(cell)
                'cell = New PdfPCell(New Phrase("Atentamente", fuente5))
                ''cell.BackgroundColor = New Color(24, 34, 133)
                'cell.BorderWidth = 0
                'cell.HorizontalAlignment = 1
                'table.AddCell(cell)

                pdfDoc.Add(table)

                dt = New DataTable
                dt = cn.Datos("select te.Nom_Emp,te.Cel_Emp,TET.Nom_Tipo_Emp,te.Mail_Emp from TJR_Empleado as TE inner join TJR_Empleado_Tipo as TET on TE.Id_Tipo_Emp = TET.Id_Tipo_Emp where id_emp = " & id_encar)
                If dt.Rows.Count > 0 Then

                    table = New PdfPTable(1)
                    widths = New Integer() {1.0F}
                    table.SetWidths(widths)
                    table.HorizontalAlignment = 2
                    table.WidthPercentage = 40
                    table.SpacingBefore = 15

                    cell = New PdfPCell(New Phrase(dt.Rows(0).Item("Nom_emp").ToString & " / Cel. " & dt.Rows(0).Item("cel_emp").ToString, fuente6))
                    'cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)
                    cell = New PdfPCell(New Phrase(dt.Rows(0).Item("nom_tipo_emp").ToString, fuente2))
                    'cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)
                    cell = New PdfPCell(New Phrase(dt.Rows(0).Item("mail_emp").ToString, fuente3))
                    'cell.BackgroundColor = New Color(24, 34, 133)
                    cell.BorderWidth = 0
                    cell.HorizontalAlignment = 1
                    table.AddCell(cell)

                    pdfDoc.Add(table)
                End If
                'MsgBox("Termine")
                pdfDoc.Close()
                'Response.Redirect("~/reporte/Cotizacion" & conexion & ".pdf")
                Response.Write(pdfDoc)
                Response.End()
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
End Class
