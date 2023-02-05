sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/equipments/test/integration/FirstJourney',
		'ns/equipments/test/integration/pages/EquipmentsList',
		'ns/equipments/test/integration/pages/EquipmentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, EquipmentsList, EquipmentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/equipments') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheEquipmentsList: EquipmentsList,
					onTheEquipmentsObjectPage: EquipmentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);