<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ingresofacturaviaticos.aspx.vb" Inherits="privado_ingresofacturaviaticos" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Ingreso Factura | <%=datos.addKey("NameProject")%></title>
  <link href="css/style.default.css" rel="stylesheet" />
  <link href="css/jquery.gritter.css" rel="stylesheet" />
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
<form class="form-horizontal form-bordered" runat="server" id="formulario">
<section>
  <div class="leftpanel">
    <div class="logopanel">
        <h1><span>[</span> <%=datos.addKey("NameProject")%> <span>]</span></h1>
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
      <h2><i class="fa fa-edit"></i> Ingreso Facturas <span>Ingresos...</span></h2>
    </div>
    <div class="contentpanel">
      <div class="panel panel-default">
        <div class="panel-body panel-body-nopadding">
            <div class="form-group">
              <label class="col-sm-2 control-label">Tipo de Liquidacion <span style="color:red;">*</span></label>
              <div class="col-sm-4">
                <select class="form-control" id="DropTipoLiquidacion">
                    <option value="0">Liquidaci&oacute;n Viaticos</option>
                    <option value="1">Liquidaci&oacute;n Fact. Versatec</option>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Tipo Documento</label>
              <div class="col-sm-4">
                <asp:DropDownList ID="DropTipoDocumento" runat="server" class="form-control"></asp:DropDownList>
              </div>
              <label class="col-sm-2 control-label">Orden de Trabajo</label>
              <div class="col-sm-4">
                <div class="input-group mb15">
                  <span class="input-group-addon">
                    <input type="checkbox" id="ChkOrdenTrabajo" />
                  </span>
                  <input type="text" class="form-control" id="TxtOrdenTrabajo" disabled />
                </div>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Nit Proveedor</label>
              <div class="col-sm-4">
                <input type="text" placeholder="" class="form-control" id="TxtNitProveedor" name="TxtNitProveedor" />
              </div>
              <label class="col-sm-2 control-label">Nombre Proveedor</label>
              <div class="col-sm-4">
                <input type="text" id="TxtNombreProveedor" placeholder="" class="form-control" disabled />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Serie</label>
              <div class="col-sm-4">
                <input type="text" placeholder="Ej. A" class="form-control" id="TxtSerieFactura" />
              </div>
              <label class="col-sm-2 control-label">Numero</label>
              <div class="col-sm-4">
                <input type="text" placeholder="Ej. 578" class="form-control" id="TxNumeroFactura" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label">Fecha</label>
              <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="input-group">
                        <input type="text" class="form-control fecha" placeholder="dd-mm-yyyy" id="TxtFecha" runat ="server" />
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </div>
              </div>
              <label class="col-sm-2 control-label">Obervacion</label>
              <div class="col-sm-4">
                <input type="text" placeholder="" class="form-control" id="TxtObservacion" />
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-2 control-label">Producto</label>
              <div class="col-sm-4">
                <asp:DropDownList ID="DropProducto" runat="server" class="form-control"></asp:DropDownList>
              </div>
              <div id="DivVehiculo" style="display:none;">
                  <label class="col-sm-2 control-label">Vehiculo</label>
                  <div class="col-sm-4">
                    <asp:DropDownList ID="DropVehiculo" runat="server" class="form-control"></asp:DropDownList>
                  </div>
              </div>
            </div>
            
            <div class="form-group">
              <label class="col-sm-2 control-label">Cantidad</label>
              <div class="col-sm-4">
                <input type="text" id="TxtCantidad" placeholder="" class="form-control" />
              </div>
              <label class="col-sm-2 control-label">Precio Unidad</label>
              <div class="col-sm-4">
                <div class="input-group">
                    <span class="input-group-addon">Q.</span>
                    <input type="text" id="TxtPrecio" placeholder="" class="form-control" />
                </div>
              </div>
            </div>            
          
        </div><!-- panel-body -->
        <div class="panel-footer">
			<div class="row">
			    <div class="col-sm-1 col-sm-offset-10">
				    <input type="button" class="btn btn-primary" id="BtnAgregarProducto" value="Agregar">
			    </div>
			</div>
		</div><!-- panel-footer -->
      </div><!-- panel -->
            <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">
          <table class="table table-hidaction table-hover mb30 FacturaDetalle" >
            <thead>
              <tr>
                <th>Codigo</th>
                <th>Descripcion</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Total</th>
                <th>Vehiculo</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
          <div class="panel panel-default">
          
            <div class="form-group">
              <div class="row">
				<div class="col-sm-1 col-sm-offset-9">
				  <input type="button" class="btn btn-primary" id="BtnGuardarFacturaViaticos" value="Guardar" />
				</div>
                <div class="col-sm-1">
				  <button class="btn btn-danger" id="BtnCancelar">Cancelar</button>
				</div>
			 </div>
            </div>
            </div>
          </div><!-- table-responsive -->
        </div><!-- col-md-12 -->
      </div><!-- row -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>
</form>
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
<script src="js/Script.js?v=1"></script>

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
        jQuery('.fecha').datepicker({
            numberOfMonths: 1,
            dateFormat: "dd-mm-yy",
            dayNamesMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
            closeOnSelect: true,
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre']
        }).mask('99-99-9999').datepicker("setDate", new Date());

        $("#<%=DropProducto.ClientID %>").change(function () {
            MostrarVehiculo($(this).val());
        });
        MostrarVehiculo($("#<%=DropProducto.ClientID %>").val());
    });
    function MostrarVehiculo(IdProducto) {
        var arr = ["GASOLINASUPER", "DIESEL", "PARQUEO", "PEAJE", "PINCHAZO"];
        if (!(jQuery.inArray(IdProducto, arr) === -1)) {
            $("#DivVehiculo").fadeIn();
        } else {
            $("#DivVehiculo").fadeOut();
        }
    }
</script>
</body>
</html>
