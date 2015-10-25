<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CargarFacturas.aspx.vb" Inherits="privado_CargarFacturas" %>

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
  <link href="css/jquery.datatables.css" rel="stylesheet">
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
                      <%--<asp:DropDownList ID="TxtNitProveedor" runat="server" class="form-control"></asp:DropDownList>--%>
                
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
            <label class="col-sm-2 control-label">Departamento</label>
              <div class="col-sm-4">
                <asp:DropDownList ID="DropDepartamento" runat="server" class="form-control"></asp:DropDownList>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-2 control-label">Producto</label>
              <div class="col-sm-4">
                <asp:DropDownList ID="DropProducto" runat="server" class="form-control"></asp:DropDownList>
              </div>
              <div id="DivVehiculo">
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
            
                 
            </div>
                 
          
        </div><!-- panel-body -->
        <div class="panel-footer">

                     <label class="col-sm-2 control-label">Archivo</label>
              <div class="col-sm-5">
             <asp:FileUpload ID="FileUpload1" runat="server" />
                


                   
                  
            <asp:Button ID="btnUpload" runat="server" Text="Subir Archivo" OnClick="btnUpload_Click" /></asp:Button>        
                  <br />
                  <asp:TextBox ID="TxtFilePath" runat="server"></asp:TextBox>
                  <asp:TextBox ID="TxtExtension" runat="server"></asp:TextBox>
                  <asp:TextBox ID="TxtYes" runat="server"></asp:TextBox>
              </div>
			
		    <input type="button" class="btn btn-primary" id="Cargar" value="Cargar Archivo">


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
				  <input type="button" class="btn btn-primary" id="BtnGuardarFactura" value="Guardar" />
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
<script src="js/jquery.datatables.min.js"></script>


<script>
    jQuery(document).ready(function () {
        $(".FacturaDetalle").dataTable({
            aLengthMenu: [
    [25, 50, 100, 200, -1],
    [25, 50, 100, 200, "All"]
            ],
            iDisplayLength: -1
        });
        // Tags Input
        jQuery('#tags').tagsInput({ width: 'auto' });
        $(".FacturaDetalle").dataTable();

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


    $("#BtnGuardarFactura").click(function (event) {
        var detalle = new Array()
        $(".FacturaDetalle tbody tr").each(function () {
            detalle.push({ codigo: $(this).find("td:eq(0)").html(), descripcion: $(this).find("td:eq(1)").html(), cantidad: $(this).find("td:eq(2)").html(), precioUnidad: $(this).find("td:eq(3)").html(), total: $(this).find("td:eq(4)").html(), vehiculo: $(this).find("td:eq(5)").html() });
        });
        $.ajax({
            type: "POST",
            url: "WebService.asmx/GuardarFacturaGastos",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'FechaFactura':'" + $("#TxtFecha").val() + "','Departamentos':'" + $("#DropDepartamento").val() + "', 'TipoDocumento': '" + $("#DropTipoDocumento").val() + "', 'OrdenTrabajo':'" + $("#TxtOrdenTrabajo").val() + "', 'NitProveedor':'" + $("#TxtNitProveedor").val() + "', 'NombreProveedor': '" + $("#TxtNombreProveedor").val() + "', 'SerieFactura': '" + $("#TxtSerieFactura").val() + "', 'NumeroFactura':'" + $("#TxNumeroFactura").val() + "', 'Observacion': '" + $("#TxtObservacion").val() + "', 'Detalle':" + JSON.stringify(detalle) + "}",
            success: function (data) {
                $.each(data.d, function (index, item) {
                    if (item.StrError == "0") {
                        jQuery.gritter.add({
                            title: 'Exito!',
                            text: 'El Ingreso se ha realizado correctamente.',
                            class_name: 'growl-success',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
                        $("select").trigger('chosen:updated');
                        $("input:text").val("");
                        $("#ChkOrdenTrabajo").attr('checked', false);
                        $("#TxtFecha").mask('99-99-9999').datepicker("setDate", new Date());
                        $("#TxtOrdenTrabajo").attr('disabled', true);
                        $(".FacturaDetalle tbody").html("");
                    } else {
                        jQuery.gritter.add({
                            title: 'Se Ha Producido Un Error!',
                            text: item.StrError,
                            class_name: 'growl-danger',
                            image: 'images/screen.png',
                            sticky: false,
                            time: ''
                        });
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





    $("#Cargar").click(function () {

        var FilePath = $("#TxtFilePath").val()
        var Extension = $("#TxtExtension").val()
        var Yes = $("#TxtYes").val()
        console.log(FilePath)
        console.log(Extension)
        console.log(Yes)
        $.ajax({
            type: "POST",
            url: "WebService.asmx/Import_To_Grid",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{FilePath:'" + FilePath + "', Extension:'" + Extension + "', isHDR:'" + Yes + "'}",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                $.each(data.d, function (index, item) {
                    $(".FacturaDetalle").dataTable().fnAddData([
                     item.Codigo,
                     item.Descripcion,
                     item.Cantidad,
                     item.Precio,
                     item.Total,
                     item.Vehiculo,
                   "<a class='delete-row baja'><i class='fa fa-trash-o'></i>"

                    ]);
                });
            },
            error: function (data) {
                console.log(data);
            }
        });
    });




</script>
</body>
</html>
