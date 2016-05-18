<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Directorios.aspx.vb" Inherits="privado_Directorios" %>

<!DOCTYPE html>

<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Vehiculos | <%=datos.addKey("NameProject")%></title>
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
      <h2><i class="fa fa-edit"></i> Clientes <span>Catalogos...</span></h2>
    </div>
    <div class="contentpanel">
          <div class="panel panel-default panel-alt widget-messaging">
          <div class="panel-heading">
              <div class="panel-btns">
                <a class="panel-edit"><button type="button" class="btn btn-primary btn-xs" id="BtnMostrarTodo"><i class="fa fa-plus-circle"></i> Mostrar Todas las Sucursales</button></a>
              </div><!-- panel-btns -->
              <h3 class="panel-title">Clientes</h3>


          
        <div id="mapdiv" style="width: 100%; background-color:#EEEEEE; height: 500px;"></div>

        
            <div>
                <div class="form-group">
                    <div class="col-md-8">
                        </div>
                    <div class="col-md-4">
               <input type="button" value="Regresar" id="btnRegresar" class="btn btn-danger btn-xs" style=display:none>
                        </div>
                </div>
             <table class="table" id="tableDetalle" style="display:none;">
                          <thead>
                             <tr>
                                <th>No</th>
                                <th>Nombre</th>
                                <th>Departamento</th>
                                <th>Municipio</th>
                                <th>Accion</th>
                             </tr>
                          </thead>
                          <tbody>
                          </tbody>
                       </table>
                </div>
         </div>
   <div class="modal fade ModalEditarVehiculo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title"><span style="display:none" id="LblModificar">Modificaion</span><span style="display:none" id="LblCrear">Creacion</span> de  Cliente a: <i><label id="Label1"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="Hidden1" />
        
                <div class="form-group">
                                <label class="col-sm-2 control-label">Nombre Compañia</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="Ej. A" class="form-control" id="TxtNombreCompañia" />
                                </div>
                                <label class="col-sm-2 control-label">Dirección</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="Ej. 578" class="form-control" id="TxtDireccion" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Departamento</label>
                                <div class="col-sm-4">
                                    <select id="DropDepartamento" class="form-control"></select>
                                </div>
                                <label class="col-sm-2 control-label">Municipio</label>
                                <div class="col-sm-4">
                                    <select id="DropMunicipios" class="form-control"></select>
                                </div>
                            </div>
                       
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Telefono</label>
                                <div class="col-sm-4">
                                    <div class="panel panel-default">
                                        
                                  <input type="text" placeholder="Ej. 578" class="form-control" id="TxtTelefono" />
                                       
                                    </div>
                                </div>
                                <label class="col-sm-2 control-label">Nombre Contacto</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="" class="form-control" id="TxtNombreContacto" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Observaciones</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="" class="form-control" id="TxtObservacion" />
                                </div>
                                    <label class="col-sm-2 control-label">Correo</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="" class="form-control" id="TxtCorreo" />
                                </div>
                            </div>

                        

                        </div>
                        <!-- panel-body -->
                  
                        <!-- panel-footer -->
                    </div>
                    <!-- panel -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">

                                <div class="panel panel-default">

                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-1 col-sm-offset-9">
                                                <input type="button" class="btn btn-primary" id="BtnGuardarDirectorio" value="Guardar" />
                                            </div>
                                            <div class="col-sm-1">
                                                <button class="btn btn-danger" id="BtnCancelar">Cancelar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- table-responsive -->
                        </div>
                        <!-- col-md-12 -->
                    </div>
                    <!-- row -->
                </div>
</div>

      
         
</div>
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
<script src="js/jquery.datatables.min.js"></script>
<script src="js/Script.js?v=1"></script>
<script src="js/funciones/Directorios.js?v=1"></script>
<link rel="stylesheet" href="js/ammap/ammap.css" type="text/css">
<script src="js/ammap/ammap.js" type="text/javascript"></script>
        <!-- map file should be included after ammap.js -->
<script src="js/ammap/maps/js/guatemalaLow.js" type="text/javascript"></script>



</body>
</html>