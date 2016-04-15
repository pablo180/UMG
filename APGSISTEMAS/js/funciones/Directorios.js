var map;

jQuery(document).ready(function () {
    map = new AmCharts.AmMap();


    map.colorSteps = 10

    var dataProvider = {
        mapVar: AmCharts.maps.guatemalaLow,

        areas: [
            {
                "id": "GT-QC",
                Value: 4447100
            },
    {
        "id": "GT-ZA",
        Value: 100
    },
    {
        "id": "GT-JU",
        "Value": 87
    },
    {
        "id": "GT-JA",
        Value:  75
    },
    {
        "id": "GT-CQ",
        Value: 80
    },
    {
        "id": "GT-IZ",
        Value: 30
    },
    {
        "id": "GT-SR",
        Value: 10
    },
    {
        "id": "GT-PR",
        Value: 5
    },
    {
        "id": "GT-TO",
        Value: 22
    },
    {
        "id": "GT-SO",
        Value: 68
    },
    {
        "id": "GT-SA",
        Value: 34
    },
    {
        "id": "GT-SU",
        Value: 67
    },
    {
        "id": "GT-GU",
        Value: 44
    },
    {
        "id": "GT-ES",
        Value: 50
    },
    {
        "id": "GT-CM",
        Value: 50
    },
    {
        "id": "GT-AV",
        Value: 50
    },
    {
        "id": "GT-SM",
        Value: 50
    },
    {
        "id": "GT-RE",
        Value: 50
    },
    {
        "id": "GT-QZ",
        Value: 50
    },
    {
        "id": "GT-PE",
        Value: 50
    },
    {
        "id": "GT-HU",
        Value: 50
    },
    {
        "id": "GT-BV",
        Value: 50
    }]
    };

    map.areasSettings = {
        autoZoom: true
    };
    map.dataProvider = dataProvider;

    var valueLegend = new AmCharts.ValueLegend();
    valueLegend.right = 10;
    valueLegend.minValue = "little";
    valueLegend.maxValue = "a lot!";
    map.valueLegend = valueLegend;

    map.write("mapdiv");
});