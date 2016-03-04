<%@ Page Language="VB" AutoEventWireup="false" CodeFile="cargarfacturasversatec.aspx.vb" Inherits="privado_cargarfacturasversatec" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Cargar Facturas | Monitoreo</title>

  <link rel="stylesheet" href="css/style.default.css" />
  
  <link rel="stylesheet" href="css/bootstrap-fileupload.min.css" />
  <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
  <link rel="stylesheet" href="css/jquery.tagsinput.css" />
  <link rel="stylesheet" href="css/colorpicker.css" />
  <link rel="stylesheet" href="css/dropzone.css" />
  <link rel="stylesheet" href="css/autocomplete.css" />
  <link rel="Stylesheet" href="css/jquery-ui.css"
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
  <link rel="stylesheet" href="css/colorpicker.css" />
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
        <h1><span>[</span> Monitoreo <span>]</span></h1>
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
      <h2><i class="fa fa-edit"></i> Facturas  <span>Ingresos...</span></h2>
    </div>
    <form class="form-horizontal form-bordered" runat="server" id="formulario">
    <div class="contentpanel">
      
      <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding">
          
          
            <div class="form-group">
            <label class="col-sm-2 control-label">Formato de Excel</label>
            <div class="col-md-12">
          <div class="table-responsive">
          <table class="table table-hidaction table-hover mb30 FacturaDetalle" >
            <thead>
              <tr>
                <th>Placa</th>
                <th>Fecha (YYYY-mm-dd)</th>
                <th>No. Factura</th>
                <th>No. Autorizacion</th>
                <th>Cantidad</th>
                <th>Precio Unidad</th>
                <th>Codigo Producto</th>
              </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
            </div>
          </div><!-- table-responsive -->
              <label class="col-sm-2 control-label">Archivo</label>
              <div class="col-sm-5">
                <div class="fileupload fileupload-new" data-provides="fileupload">
                  <div class="input-append">
                    <div class="uneditable-input">
                      <i class="glyphicon glyphicon-file fileupload-exists"></i>
                      <span class="fileupload-preview"></span>
                    </div>
                    <span class="btn btn-default btn-file">
                      <span class="fileupload-new">Seleccionar</span>
                      <span class="fileupload-exists">Cambiar</span>
                      <asp:FileUpload ID="CargarExcel" runat="server" CssClass="form-control"></asp:FileUpload>
                    </span>
                    <a href="#" class="btn btn-default fileupload-exists" data-dismiss="fileupload">Quitar</a>
                  </div>
                </div>
              </div>
            </div>
                 
          
        </div><!-- panel-body -->
        <div class="panel-footer">
			 <div class="row">
				<div class="col-sm-1 col-sm-offset-10">
                <asp:Button ID="BtnCargarFactura" runat="server" Text="Cargar" CssClass="btn btn-primary"></asp:Button>&nbsp;
				</div>
			 </div>
		  </div><!-- panel-footer -->
      </div><!-- panel -->
      <asp:GridView ID="GridView1" runat="server">
    </asp:GridView>
    </form>
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
<script src="js/Script.js"></script>

<script>
    jQuery(document).ready(function () {

        // Tags Input
        jQuery('#tags').tagsInput({ width: 'auto' });

        // Textarea Autogrow
        jQuery('#autoResizeTA').autogrow();

        // Color Picker
        if (jQuery('#colorpicker').length > 0) {
            jQuery('#colorSelector').ColorPicker({
                onShow: function (colpkr) {
                    jQuery(colpkr).fadeIn(500);
                    return false;
                },
                onHide: function (colpkr) {
                    jQuery(colpkr).fadeOut(500);
                    return false;
                },
                onChange: function (hsb, hex, rgb) {
                    jQuery('#colorSelector span').css('backgroundColor', '#' + hex);
                    jQuery('#colorpicker').val('#' + hex);
                }
            });
        }

        // Color Picker Flat Mode
        jQuery('#colorpickerholder').ColorPicker({
            flat: true,
            onChange: function (hsb, hex, rgb) {
                jQuery('#colorpicker3').val('#' + hex);
            }
        });

        // Date Picker
        jQuery('#datepicker').datepicker();

        jQuery('#datepicker-inline').datepicker();

        jQuery('#TxtFecha').datepicker({
            numberOfMonths: 1,
            dateFormat: "dd-mm-yy",
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            closeOnSelect: true,
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        }).mask('99-99-9999').datepicker("setDate", new Date());

        // Spinner
        var spinner = jQuery('#spinner').spinner();
        spinner.spinner('value', 0);

        // Input Masks
        jQuery("#date").mask("99/99/9999");
        jQuery("#phone").mask("(999) 999-9999");
        jQuery("#ssn").mask("999-99-9999");

        // Time Picker
        jQuery('#timepicker').timepicker({ defaultTIme: false });
        jQuery('#timepicker2').timepicker({ showMeridian: false });
        jQuery('#timepicker3').timepicker({ minuteStep: 15 });


    });
</script>
</body>
</html>
