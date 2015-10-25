<%@ Page Language="VB" AutoEventWireup="false" CodeFile="recibosdeviaticos.aspx.vb" Inherits="privado_recibosdeviaticos" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Recibos de Viaticos | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/colorpicker.css" />
  <link href="css/jquery.datatables.css" rel="stylesheet" />
  <link href="css/dataTables.tableTools.min.css" rel="stylesheet" />
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body>

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>
<section>
  <div class="leftpanel">
    <div class="logopanel">
        <h1><span>[</span> <% =datos.addKey("NameProject")%> <span>]</span></h1>
    </div><!-- logopanel -->
    <div class="leftpanelinner">
        <!-- This is only visible to small devices -->
        <!-- #include file="usuario.html"-->
      
      <h5 class="sidebartitle">Men&uacute;</h5>
      <!--#include file="menu.html" -->
    </div><!-- leftpanelinner -->
  </div><!-- leftpanel -->
  
  <div class="mainpanel">
    
    <div class="headerbar">
      <a class="menutoggle"><i class="fa fa-bars"></i></a>
      <!-- #INCLUDE FILE="usuariomenu.html" --> 
    </div><!-- headerbar -->
    
    <div class="pageheader">
      <h2><i class="fa fa-edit"></i> Recibos Viaticos <span>Ingresos...</span></h2>
    </div>
    
    <div class="contentpanel">
      
      <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding">
          
          <form class="form-horizontal form-bordered" runat="server" id="formulario">
            <div class="form-group">
              <label class="col-sm-2 control-label">Fecha Inicio</label>
              <div class="col-sm-4">
                <input type="text" placeholder="YYYY-mm-dd" class="form-control fecha" id="TxtFechaInicio" name="TxtFechaInicio" />
              </div>
              <label class="col-sm-2 control-label">Fecha Fin</label>
              <div class="col-sm-4">
                <input type="text" id="TxtFechaFin" name="TxtFechaFin" placeholder="YYYY-mm-dd" class="form-control fecha" />
              </div>
            </div>        
          </form>
        </div><!-- panel-body -->
        <div class="panel-footer">
			 <div class="row">
				<div class="col-sm-1 col-sm-offset-10">
				  <button class="btn btn-primary" id="BtnActualizar">Actualizar</button>&nbsp;
				</div>
			 </div>
		  </div><!-- panel-footer -->
      </div><!-- panel -->
      <div class="row">
        <div class="col-md-12">
            <div class="table-responsive" style="" id="DivDetalle">
                <table class="table" id="DetalleRecibos" >
                    <thead>
                        <tr><th>Fecha de Liquidacion</th><th>Fecha de Factura</th><th>Serie</th><th>No. Factura</th><th>No. Liquidacion</th><th>Nombre</th><th>Cta. Contable</th><th>Articulo (Codigo)</th><th>Total</th></tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>    
            </div><!-- table-responsive -->
        </div>
      </div><!-- row -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/jquery-ui-1.10.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script src="js/jquery.autogrow-textarea.js"></script>
<script src="js/bootstrap-fileupload.min.js"></script>
<script src="js/bootstrap-timepicker.min.js"></script>
<script src="js/jquery.maskedinput.min.js"></script>
<script src="js/jquery.tagsinput.min.js"></script>
<script src="js/jquery.mousewheel.js"></script>
<script src="js/chosen.jquery.min.js"></script>
<script src="js/dropzone.min.js"></script>
<script src="js/colorpicker.js"></script>
<script src="js/jquery.gritter.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/jquery.datatables.min.js"></script>
<script src="js/dataTables.tableTools.js"></script>
<script src="js/Script.js"></script>

<script>
    jQuery(document).ready(function () {
        $("#DetalleRecibos").DataTable({
            "sDom": 'T<"clear">lfrtip',
            "oTableTools": {
                "sSwfPath": "swf/copy_csv_xls_pdf.swf",
                "aButtons": [
                    "copy",
                    "print",
                    {
                        "sExtends": "collection",
                        "sButtonText": "Save",
                        "aButtons": ["csv", "xls", "pdf"]
                    }
                ]
            }
        });
        jQuery('.fecha').datepicker({
            numberOfMonths: 1,
            dateFormat: "dd-mm-yy",
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            closeOnSelect: true,
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        }).mask('99-99-9999').datepicker("setDate", new Date());
        $("#BtnActualizar").click(function () {
            $('#DetalleRecibos').dataTable().fnClearTable();
            $.ajax({
                type: "POST",
                url: "WebService.asmx/RecibosDeViaticos",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{ FechaInicio:'" + $("#TxtFechaInicio").val() + "', FechaFin:'" + $("#TxtFechaFin").val() + "'}",
                success: function (data) {
                    console.log(data.d);
                    $.each(data.d, function (i, item) {
                        if (item.StrError != "0") {
                            jQuery.gritter.add({
                                title: 'Se Ha Producido Un Error!',
                                text: item.StrError,
                                class_name: 'growl-danger',
                                image: 'images/screen.png',
                                sticky: false,
                                time: ''
                            });
                            return;
                        } else {
                            $('#DetalleRecibos').dataTable().fnAddData([
        			    item.FechaLiquidacion,
        			    item.FechaFactura,
        			    item.Serie,
                        item.NoFactura,
        			    item.IdLiquidacion,
        			    item.Nombre,
                        item.CuentaContable,
                        item.Codigo,
                        item.Total]);
                        }
                    });
                },
                error: function (data) {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.responseText,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
            });
        });
    });
</script>
</body>
</html>
