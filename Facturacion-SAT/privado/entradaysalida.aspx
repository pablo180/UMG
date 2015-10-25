<%@ Page Language="VB" AutoEventWireup="false" CodeFile="entradaysalida.aspx.vb" Inherits="privado_entradaysalida" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Ingreso y Salida | Monitoreo</title>
  <link href="css/style.default.css" rel="stylesheet">
  <link href="css/jquery.datatables.css" rel="stylesheet">
  <style>td{border: solid #ffffff 1px;cursor:pointer;cursor:hand;}</style>
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
      <h2><i class="fa fa-exchange"></i> Ingresos Y Salidas <span>Reportes</span></h2>
    </div>
    
    <div class="contentpanel">
      
      <div class="row">
        <div class="col-md-12">
          <h5 class="subtitle mb5">Informaci&oacute;n de ingresos y salidas.</h5>
          <p class="mb20">Ingresos y Salidas a Predio de Gentrac </p>
          <div class="table-responsive">
          <table class="table mb30">
            <thead>
              <tr>
                <th>Placa</th>
                <th>Concepto</th>
                <th>1</th>
                <th>2</th>
                <th>3</th>
                <th>4</th>
                <th>5</th>
                <th>6</th>
                <th>7</th>
                <th>8</th>
                <th>9</th>
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
              <tr >
                <td rowspan="2">V-649</td>
                <td>Entrada<span style="font-size:0.75em;">(8:00am)</span></td>
                <td style="background-color:#5f1402;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#5f1402; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#5f1402; color:#FFFFFF;"></td>
                <td style="background-color:#5f1402; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
              </tr>
              <tr>
                <td>Salida<span style="font-size:0.75em;">(5:00pm)</span></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#5f1402; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#5f1402; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#5f1402; color:#FFFFFF;"></td>
                <td style="background-color:#5f1402; color:#FFFFFF;"></td>
              </tr>
              <tr>
                <td rowspan="2">V-412</td>
                <td>Entrada<span style="font-size:0.75em;">(8:00am)</span></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02;"></td>
              </tr>
              <tr>
                <td>Salida<span style="font-size:0.75em;">(5:00pm)</span></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#becf00;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02; color:#FFFFFF;"></td>
                <td style="background-color:#145f02;"></td>
                <td style="background-color:#145f02;"></td>
              </tr>
            </tbody>
          </table>
          </div><!-- table-responsive -->
        </div><!-- col-md-12 --> 
      </div><!-- row -->
    </div><!-- tab-content -->
  </div><!-- rightpanel -->
  
</section>


<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>

<script src="js/jquery.datatables.min.js"></script>
<script src="js/chosen.jquery.min.js"></script>

<script src="js/custom.js"></script>
<script>
    jQuery(document).ready(function () {

        jQuery('#table1').dataTable();

        jQuery('#table2').dataTable({
            "sPaginationType": "full_numbers"
        });

        // Chosen Select
        jQuery("select").chosen({
            'min-width': '100px',
            'white-space': 'nowrap',
            disable_search_threshold: 10
        });

        // Delete row in a table
        jQuery('.delete-row').click(function () {
            var c = confirm("Continue delete?");
            if (c)
                jQuery(this).closest('tr').fadeOut(function () {
                    jQuery(this).remove();
                });

            return false;
        });

        // Show aciton upon row hover
        jQuery('.table-hidaction tbody tr').hover(function () {
            jQuery(this).find('.table-action-hide a').animate({ opacity: 1 });
        }, function () {
            jQuery(this).find('.table-action-hide a').animate({ opacity: 0 });
        });


    });
</script>

</body>
</html>
