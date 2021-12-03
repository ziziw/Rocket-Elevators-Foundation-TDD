console.log('interventions js file loaded');

$('#intervention_customer_select').change((e) => {
    e.preventDefault();
    console.log('entered customer_select!!!!');
    $('#buildingSetId').show();
    $.ajax({
        type: 'GET',
        dataType: 'json',
        cache: false,
        url: '/get_buildings/' + this.value,
        data: data,
        timeout: 5000,
        async: false,
        success: (data) => {
            $('#intervention_building_select').find('option').not(':first').remove();
            for (let i = 0; i < data.length; i++) {
                $('#intervention_building_select').append($('<option/>', { key: data[i].id, text: data[i].id }));
            }
        },
    });
});

$('#intervention_building_select').change((e) => {
    e.preventDefault();
    console.log('entered building_select!!!!');
    $('#batterySetId').show();
    $.ajax({
        type: 'GET',
        dataType: 'json',
        cache: false,
        url: '/get_batteries/' + this.value,
        data: data,
        timeout: 5000,
        async: false,
        success: (data) => {
            $('#intervention_battery_select').find('option').not(':first').remove();
            for (let i = 0; i < data.length; i++) {
                $('#intervention_battery_select').append($('<option/>', { key: data[i].id, text: data[i].id }));
            }
        },
    });
});

$('#intervention_battery_select').change((e) => {
    e.preventDefault();
    console.log('entered battery_select!!!!');
    $('#columnSetId').show();
    $.ajax({
        type: 'GET',
        dataType: 'json',
        cache: false,
        url: '/get_column/' + this.value,
        data: data,
        timeout: 5000,
        async: false,
        success: (data) => {
            $('#intervention_column_select').find('option').not(':first').remove();
            for (let i = 0; i < data.length; i++) {
                $('#intervention_column_select').append($('<option/>', { key: data[i].id, text: data[i].id }));
            }
        },
    });
});

$('#intervention_column_select').change((e) => {
    e.preventDefault();
    console.log('entered column_select!!!!');
    $('#elevatorSetId').show();
    $.ajax({
        type: 'GET',
        dataType: 'json',
        cache: false,
        url: '/get_column/' + this.value,
        data: data,
        timeout: 5000,
        async: false,
        success: (data) => {
            $('#intervention_elevator_select').find('option').not(':first').remove();
            for (let i = 0; i < data.length; i++) {
                $('#intervention_elevator_select').append($('<option/>', { key: data[i].id, text: data[i].id }));
            }
        },
    });
});
