﻿jQuery(document).ready(function () {
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
    });
    $(".TablaClientes tbody").on("click", ".BtnEditarCliente", function () {
        //            IndexTr = $(this).parent().parent().index();
        //            $(".TableVehiculos").dataTable().fnDeleteRow(IndexTr);
        $("#BtnEditarC").show();
        $("#BtnGuardarC").hide();
        $("#LblModificar").show();
        $("#LblCrear").hide();
        var id = this.id;

        //$("#CheckPool div").removeClass("active");
        $.ajax({
            type: "POST",
            url: "wsUnidad.asmx/CatalogoClientes",
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
    $(".TablaClientes").dataTable().fnClearTable();
    $.ajax({
        type: "POST",
        url: "wsUnidad.asmx/CatalogoClientes",
        data: "{ 'IdCliente': " + id + " }",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            $.each(data.d, function (index, item) {
                $(".TablaClientes").dataTable().fnAddData([
                    item.codigo,
                    item.Descripcion,
                    item.Estado,
                    "<button type='button' id='" + item.codigo + "' class='btn btn-default btn-xs BtnEditarCliente'  aria-label='Left Align'><i class='glyphicon glyphicon-edit EditarCliente'></i> Editar</button>"
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
            url: "wsUnidad.asmx/EditarCliente",
            data: "{'Id':" + $("#textMDId").val() + ",'Descripcion':'" + $("#textMDNombre").val() + "', 'Estatus':" + $("#DropEstatus").val() + "}",
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.d[0].StrError == "0") {
                    $(".TablaClientes").dataTable().fnClearTable();
           
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

        $.ajax({
            type: "POST",
            url: "wsUnidad.asmx/GuardarCliente",
            data: "{'Descripcion':'" + $("#textMDNombre").val() + "', 'Estatus':" + $("#DropEstatus").val() + "}",
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
                    $(".TablaClientes").dataTable().fnClearTable();
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
