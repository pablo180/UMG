<%@ Page Language="VB" AutoEventWireup="false" CodeFile="recorridoUnidad.aspx.vb" Inherits="privado_recorridoUnidad" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
  <title>Recorrido Vehiculo | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/amCharts.css" rel="stylesheet" type="text/css" />
  <link href="css/jquery.datatables.css" rel="stylesheet">
  <link href="css/jquery.gritter.css" rel="stylesheet">
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
      <h2><i class="fa fa-th-large"></i> Rendimiento Vehiculo <span>Reportes</span></h2>
    </div>
    <div class="contentpanel">
      <div class="row">
        <div class="col-md-12">
          <div class="panel panel-default">
            <div class="panel-heading">
              
              <h4 class="panel-title">Filtros:</h4>
              <form runat="Server" id="filtro">
                <div class="form-group">
                    <label class="col-sm-2">Departamento:</label>
                    <div class="col-sm-4">
                       <asp:DropDownList ID="DropDepartamentos" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <label class="col-sm-2">Año:</label>
                    <div class="col-sm-4">
                       <asp:DropDownList ID="DropYear" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2">Mes:</label>
                    <div class="col-sm-4">
                       <asp:DropDownList ID="DropMes" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
            </form>
            </div>
            <div class="panel-body panel-body-nopadding">
              <!-- BASIC WIZARD -->
              <div id="basicWizard" class="basic-wizard">
                <ul class="nav nav-pills nav-justified">
                <%--  <li><a href="#tab1" data-toggle="tab"><span>Rendimiento:</span> Combustible</a></li>
                  <li><a href="#tab2" data-toggle="tab"><span>Rendimiento:</span> Aceite de Motor</a></li>
                  <li><a href="#tab3" data-toggle="tab"><span>Rendimiento:</span> Aceite de Caja</a></li>--%>
                  <li><a href="#tab1" data-toggle="tab"><span>Kilometrajes:</span></a></li>
                </ul>
                <div class="tab-content">
                  <div class="row" id="tab1">
                    <div class="table-responsive">
                      <table class="table mb30">
                        <thead>
                          <tr>
                            <th>Vehiculo</th>
                            <th>01</th>
                            <th>02</th>
                            <th>03</th>
                            <th>04</th>
                            <th>05</th>
                            <th>06</th>
                            <th>07</th>
                            <th>08</th>
                            <th>09</th>
                            <th>10</th>
                            <th>11</th>
                            <th>12</th>
                            <th>13</th>
                            <th>14</th>
                            <th>15</th>
                            <th>16</th>
                            <th>17</th>
                            <th>18</th>
                            <th>19</th>
                            <th>20</th>
                            <th>21</th>
                            <th>22</th>
                            <th>23</th>
                            <th>24</th>
                            <th>25</th>
                            <th>26</th>
                            <th>27</th>
                            <th>28</th>
                            <th>29</th>
                            <th>30</th>
                            <th>31</th>
                          </tr>
                        </thead>
                        <tbody>
                        </tbody>
                      </table>
                      </div><!-- table-responsive -->
                  </div>
                 
                </div><!-- tab-content -->
                <%--<ul class="pager wizard">
                    <li class="previous"><a href="javascript:void(0)">Previous</a></li>
                    <li class="next"><a href="javascript:void(0)">Next</a></li>
                  </ul>--%>
              </div><!-- #basicWizard -->
            </div><!-- panel-body -->
          </div><!-- panel -->
        </div><!-- col-md-12 -->
      </div><!-- row -->
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
</section>
<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>
<script src="js/amCharts/amcharts.js" type="text/javascript"></script>
<script src="js/amCharts/pie.js" type="text/javascript"></script>
<script src="js/amCharts/serial.js" type="text/javascript"></script>
<script src="js/bootstrap-wizard.min.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/chosen.jquery.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/jquery.datatables.min.js"></script>
<script src="js/jquery.gritter.min.js"></script>
<script>
    jQuery(document).ready(function () {
        jQuery('#table2').dataTable({
            "sPaginationType": "full_numbers"
        });
        jQuery("select").chosen({ 'width': '100%', 'white-space': 'nowrap' });
        // Basic Wizard
        jQuery('#basicWizard').bootstrapWizard();

        // Progress Wizard
        $('#progressWizard').bootstrapWizard({
            'nextSelector': '.next',
            'previousSelector': '.previous',
            onNext: function (tab, navigation, index) {
                var $total = navigation.find('li').length;
                var $current = index + 1;
                var $percent = ($current / $total) * 100;
                jQuery('#progressWizard').find('.progress-bar').css('width', $percent + '%');
            },
            onPrevious: function (tab, navigation, index) {
                var $total = navigation.find('li').length;
                var $current = index + 1;
                var $percent = ($current / $total) * 100;
                jQuery('#progressWizard').find('.progress-bar').css('width', $percent + '%');
            },
            onTabShow: function (tab, navigation, index) {
                var $total = navigation.find('li').length;
                var $current = index + 1;
                var $percent = ($current / $total) * 100;
                jQuery('#progressWizard').find('.progress-bar').css('width', $percent + '%');
            }
        });

        // Disabled Tab Click Wizard
        jQuery('#disabledTabWizard').bootstrapWizard({
            tabClass: 'nav nav-pills nav-justified nav-disabled-click',
            onTabClick: function (tab, navigation, index) {
                return false;
            }
        });

        // With Form Validation Wizard
        var $validator = jQuery("#firstForm").validate({
            highlight: function (element) {
                jQuery(element).closest('.form-group').removeClass('has-success').addClass('has-error');
            },
            success: function (element) {
                jQuery(element).closest('.form-group').removeClass('has-error');
            }
        });

        jQuery('#validationWizard').bootstrapWizard({
            tabClass: 'nav nav-pills nav-justified nav-disabled-click',
            onTabClick: function (tab, navigation, index) {
                return false;
            },
            onNext: function (tab, navigation, index) {
                var $valid = jQuery('#firstForm').valid();
                if (!$valid) {

                    $validator.focusInvalid();
                    return false;
                }
            }
        });


    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        RecorridoMensual();
        $("#<%=DropDepartamentos.ClientID %>").change(function () {
            $("table tbody").html("");
            RecorridoMensual();
        });
        $("#<%=DropYear.ClientID %>").change(function () {
            $("table tbody").html("");
            RecorridoMensual();
        });
        $("#<%=DropMes.ClientID %>").change(function () {
            $("table tbody").html("");
            RecorridoMensual();
        });
    });
    function RecorridoMensual(event) {
        $.ajax({
            type: "POST",
            url: "WebService.asmx/RecorridoMensual",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{Departamento:" + $("#<%=DropDepartamentos.ClientID %>").val() + ", Year:" + $("#<%=DropYear.ClientID %>").val() + ", Mes:" + $("#<%=DropMes.ClientID %>").val() + "}",
            success: function (data) {
                //console.log.log(data);
                if (data.d.length < 1) {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: 'No Hay Datos',
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
                $.each(data.d, function (i, item) {
                    if (item.StrError != "0") {
                        //console.log.log(item.StrError);
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
                        if (item.Vehiculo != "0") {
                            if ($("table tbody tr td:contains('" + item.Vehiculo + "')").length >= 1) {

                            } else {
                                $("table tbody").append("<tr><td>" + item.Vehiculo + "</td><td class='" + item.Vehiculo + "_1 btn-danger'>0</td><td class='" + item.Vehiculo + "_2 btn-danger'>0</td><td class='" + item.Vehiculo + "_3 btn-danger'>0</td><td class='" + item.Vehiculo + "_4 btn-danger'>0</td><td class='" + item.Vehiculo + "_5 btn-danger'>0</td><td class='" + item.Vehiculo + "_6 btn-danger'>0</td><td class='" + item.Vehiculo + "_7 btn-danger'>0</td><td class='" + item.Vehiculo + "_8 btn-danger'>0</td><td class='" + item.Vehiculo + "_9 btn-danger'>0</td><td class='" + item.Vehiculo + "_10 btn-danger'>0</td><td class='" + item.Vehiculo + "_11 btn-danger'>0</td><td class='" + item.Vehiculo + "_12 btn-danger'>0</td><td class='" + item.Vehiculo + "_13 btn-danger'>0</td><td class='" + item.Vehiculo + "_14 btn-danger'>0</td><td class='" + item.Vehiculo + "_15 btn-danger'>0</td><td class='" + item.Vehiculo + "_16 btn-danger'>0</td><td class='" + item.Vehiculo + "_17 btn-danger'>0</td><td class='" + item.Vehiculo + "_18 btn-danger'>0</td><td class='" + item.Vehiculo + "_19 btn-danger'>0</td><td class='" + item.Vehiculo + "_20 btn-danger'>0</td><td class='" + item.Vehiculo + "_21 btn-danger'>0</td><td class='" + item.Vehiculo + "_22 btn-danger'>0</td><td class='" + item.Vehiculo + "_23 btn-danger'>0</td><td class='" + item.Vehiculo + "_24 btn-danger'>0</td><td class='" + item.Vehiculo + "_25 btn-danger'>0</td><td class='" + item.Vehiculo + "_26 btn-danger'>0</td><td class='" + item.Vehiculo + "_27 btn-danger'>0</td><td class='" + item.Vehiculo + "_28 btn-danger'>0</td><td class='" + item.Vehiculo + "_29 btn-danger'>0</td><td class='" + item.Vehiculo + "_30 btn-danger'>0</td><td class='" + item.Vehiculo + "_31 btn-danger'>0</td></tr>");
                            }
                        }
                    }
                });
                $.each(data.d, function (i, item) {
                    if (item.Vehiculo != "0") {
                        if (parseFloat(item.Recorrido) > 0) {
                            $("." + item.Vehiculo + "_" + item.Dia).html(item.Recorrido).removeClass("btn-danger").addClass("btn-success");
                        }
                    }
                });
            },
            error: function (data) {
                //console.log.log(data);
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

    }
</script>
</body>
</html>
