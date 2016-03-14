<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Categorias.aspx.vb" Inherits="privado_Categorias" %>

<!DOCTYPE html>

<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Provedores | <%=datos.addKey("NameProject")%></title>
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
      <h2><i class="fa fa-edit"></i> Categorias <span>Catalogos...</span></h2>
    </div>
    <div class="contentpanel">
          <div class="panel panel-default panel-alt widget-messaging">
          <div class="panel-heading">
              <div class="panel-btns">
                <a class="panel-edit"><button type="button" class="btn btn-primary btn-xs" id="BtnNuevoCliente"><i class="fa fa-plus-circle"></i> Nuevo</button></a>
              </div><!-- panel-btns -->
              <h3 class="panel-title">Categorias</h3>
            </div>
            <div class="panel-body">
                <table class="table table-hidaction table-hover mb30 TablaCategorias" >
                    <thead>
                        <tr>
                            <th>Codigo</th>
                            <th>Descripcion</th>
                            <th>Estado</th>
                            <th></th>
                             <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div><!-- panel-body -->
          </div><!-- panel -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>
<div class="modal fade ModalEditarVehiculo" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" data-backdrop="static" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button aria-hidden="true" data-dismiss="modal" class="close" type="button">&times;</button>
            <h4 class="modal-title"><span style="display:none" id="LblModificar">Modificaion</span><span style="display:none" id="Lbl">Creacion</span><span style="display:none" id="LblCrear">Creacion</span> <span style="display:none" id="LblEliminar">Eliminacion </span>de  Categoria : <i><label id="Label1"></label></i></h4>
        </div>
        <div class="modal-body">
        <input type="hidden" id="Hidden1" />
        
            <div class="form-group" style=display:none id="divformulario" >
                     <label class="col-md-2">Descripcion:</label>
                <div class="col-md-4">
                    <input type="text" id="textMDNombre"  name="textMDNombre" class="form-control" />
                    <input type="hidden" id="textMDId" name="textMDId" class="form-control" />

                </div>
                <label class="col-md-2">Estatus:</label>
                  <div class="col-md-4">
                     <select id="DropEstatus" name="DropEstatus" style="width:100%;">
                        <option value="1">Alta</option>
                        <option value="0">Baja</option>
                     </select>
                 </div>
            
            </div>

             <div class="form-group" style=display:none id="divformularioEliminar" >
                 <h3>¿Esta Seguro que desea eliminar esta categoria?</h3>
                 </div>

            <div class="form-group" style=display:none id="divformularioVerificar" >
            <div class="form-group" 
                <h2>Los siguientes productos tienen la clasificacion que desea eliminar por favor cambielos de claficiacion para poder continuar </h2>
                  </div>
            <div class="form-group">

                <table class="table table-hidaction table-hover mb30 TablaProductos" >
                    <thead>
                        <tr>
                            <th>Codigo</th>
                            <th>Descripcion</th>
                        
                          
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                  </div>
                 </div>
       </div>
      
            <div class="form-group">
                <div class="col-md-4">
                </div>
                 <div class="col-md-4">
                </div>
                <div class="col-md-4">
                    <div class="btn-demo">
                          <div class="form-group">
                                          <div class="col-md-6">
                        <input type="button" id="BtnEditarC" class="btn btn-primary" value="Guardar" />
                        <input type="button" id="BtnGuardarC" class="btn btn-primary" value="Guardar" />
                        <input type="button" id="BtnEliminarC" class="btn btn-primary" value="Eliminar" />
                                                  </div>
                                                  <div class="col-md-6">
                        <input type="button" id="BtnCancelarC" class="btn btn-danger" value="Cancelar" />
                                                          </div>
                 </div>
                       <div class="col-md-12"> 
                    
                </div>
            </div>
        </div>
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
<script src="js/funciones/Categorias.js?v=1"></script>



</body>
</html>