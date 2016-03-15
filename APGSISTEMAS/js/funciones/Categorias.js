jQuery(document).ready(function () {
    $(".TablaClientes").dataTable();
    MostrarClientes(0);
    var IndexTr;
    $("#BtnNuevoCliente").click(function () {
        $("input:text").val("");
        $("#textMDId").val("");
        $('select').val(0).trigger("chosen:updated");
        $('.ModalEditarVehiculo').modal('toggle');
        $("#BtnGuardarC").show();
        $("#BtnEditarC").hide();
        $("#LblModificar").hide();
        $("#LblCrear").show();
        $("#BtnEliminarC").hide();
        $("#LblEliminar").hide();
        $("#divformulario").show();
        $("#divformularioEliminar").hide();
        $("#divformularioVerificar").hide();


  
    });
    $(".TablaCategorias tbody").on("click", ".BtnEditarCategoria", function () {
        //            IndexTr = $(this).parent().parent().index();
        //            $(".TableVehiculos").dataTable().fnDeleteRow(IndexTr);
        $("#BtnEditarC").show();
        $("#BtnGuardarC").hide();
        $("#LblModificar").show();
        $("#LblCrear").hide();
        $("#BtnEliminarC").hide();
        $("#LblEliminar").hide();
        $("#divformulario").show();
        $("#divformularioEliminar").hide();
        $("#divformularioVerificar").hide();

        var id = this.id;

        //$("#CheckPool div").removeClass("active");
        $.ajax({
            type: "POST",
            url: "wsCategorias.asmx/CatalogoClientes",
            data: "{ 'IdCliente': " + id + " }",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                $.each(data.d, function (index, item) {
                    $("#textMDId").val(item.codigo);
                    // $("#textMDPool").val(item.poolv);
                    $("#textMDCodigo").val(item.codigo);
                    $("#textMDNombre").val(item.Descripcion);
                    $('#DropEstatus').val(item.IdEstado).trigger("chosen:updated");
                    $('#TxtCOEncargado').val(item.Correo).trigger("chosen:updated");
                    if (item.IdEstado) {
                        $('#DropEstatus').val(1).trigger("chosen:updated");
                    } else {
                        $('#DropEstatus').val(0).trigger("chosen:updated");
                    }

                });
                $('.ModalEditarVehiculo').modal('toggle');
            },
            error: function (data) {
                console.log(data);
            }
        });
    });
});
function MostrarClientes(id) {
 

   

    $.ajax({
        type: "POST",
        url: "wsCategorias.asmx/CatalogoClientes",
        data: "{ 'IdCliente': " + id + " }",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $.each(data.d, function (index, item) {
                $(".TablaCategorias").dataTable().fnAddData([
                    item.codigo,
                    item.Descripcion,
                    item.Estado,
                    "<button type='button' id='" + item.codigo + "' class='btn btn-default btn-xs BtnEditarCategoria'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarCliente'></i> Editar</button>",
                    "<button type='button' id='" + item.codigo + "' class='btn btn-default btn-xs BtnEliminarCategoria'  aria-label='Left Align'><i class='glyphicon glyphicon-remove EliminarEditarCliente'></i> Eliminar</button>"

                ]);
            });
        },
        error: function (data) {
            console.log(data);
        }
    });
}

$(document).ready(function () {
    $("#BtnEditarC").click(function () {
      
        $.ajax({
            type: "POST",
            url: "wsCategorias.asmx/EditarCliente",
            data: "{'Id':" + $("#textMDId").val() + ",'Nombre':'" + $("#textMDNombre").val() + "', 'Estatus':" + $("#DropEstatus").val() + "}",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d[0].StrError == "0") {
                    $(".TablaCategorias").dataTable().fnClearTable();
            
                    $("input:text, input:hidden").val("");
                    jQuery.gritter.add({
                        title: 'Exito!',
                        text: 'La Operacion Se Ha Realizado Correctamente.',
                        class_name: 'growl-info',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });

                    $('.ModalEditarVehiculo').modal('hide');
                    MostrarClientes(0);
                } else {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.d[0].StrError,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
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
$(document).ready(function () {
    $("#BtnGuardarC").click(function () {
        $(".TablaCategorias").dataTable().fnClearTable();
        $.ajax({
            type: "POST",
            url: "wsCategorias.asmx/GuardarCategoria",
            data: "{'Nombre':'" + $("#textMDNombre").val() + "', 'Estatus':" + $("#DropEstatus").val() + "}",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                var NuevoId = data.d[0].IdVehiculo;
                if (data.d[0].StrError == "0") {
                    $("input:text, #textMDId").val("");
                    jQuery.gritter.add({
                        title: 'Exito!',
                        text: 'La Operacion Se Ha Realizado Correctamente.',
                        class_name: 'growl-info',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });

                    $('.ModalEditarVehiculo').modal('hide');
                    MostrarClientes(0);
                } else {
                    jQuery.gritter.add({
                        title: 'Se Ha Producido Un Error!',
                        text: data.d[0].StrError,
                        class_name: 'growl-danger',
                        image: 'images/screen.png',
                        sticky: false,
                        time: ''
                    });
                }
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

}); //JQuery

$(".TablaCategorias tbody").on("click", ".BtnEliminarCategoria", function () {
    //            IndexTr = $(this).parent().parent().index();
    //            $(".TableVehiculos").dataTable().fnDeleteRow(IndexTr);
    $("#BtnEditarC").hide();
    $("#BtnEliminarC").show();
    $("#BtnGuardarC").hide();
    $("#LblModificar").hide();

    $("#divformulario").hide();
    $("#LblCrear").hide();
    $("#LblEliminar").show();
    $("#divformularioEliminar").show();

    var id = this.id;
 

    $("#textMDId").val(id)




    $(".TablaProductos").dataTable().fnClearTable();


    //$("#CheckPool div").removeClass("active");
    $.ajax({
        type: "POST",
        url: "wsCategorias.asmx/CatalogoProductos",
        data: "{ 'IdCatedoria': " + id + " }",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $.each(data.d, function (index, item) {
                if (item.Resultado == 0){

                    $("#divformularioEliminar").show();
                    $("#divformularioVerificar").hide();
                    $("#BtnEliminarC").show();
          
                    
                }else{
                    $(".TablaProductos").dataTable().fnAddData([
                   item.codigo,
                   item.Descripcion
                    ]);
                    $("#divformularioVerificar").show();
            
                    $("#BtnEliminarC").hide();
                    $("#divformularioEliminar").hide();


            }
            });
            $('.ModalEditarVehiculo').modal('toggle');
        },
        error: function (data) {
            console.log(data);
        }
    });
});





$("#BtnEliminarC").click(function () {
    var id = $("#textMDId").val();
    console.log(id)
    $(".TablaCategorias").dataTable().fnClearTable();
    $.ajax({
        type: "POST",
        url: "wsCategorias.asmx/EliminarCategoria",
        data: "{'Id': '" + id + "' }",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            var NuevoId = data.d[0].IdVehiculo;
            if (data.d[0].StrError == "0") {
                $("input:text, #textMDId").val("");
                jQuery.gritter.add({
                    title: 'Exito!',
                    text: 'La Operacion Se Ha Realizado Correctamente.',
                    class_name: 'growl-info',
                    image: 'images/screen.png',
                    sticky: false,
                    time: ''
                });

                $('.ModalEditarVehiculo').modal('hide');
                MostrarClientes(0);
            } else {
                jQuery.gritter.add({
                    title: 'Se Ha Producido Un Error!',
                    text: data.d[0].StrError,
                    class_name: 'growl-danger',
                    image: 'images/screen.png',
                    sticky: false,
                    time: ''
                });
            }
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