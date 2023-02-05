using RiskService from './risk-service';

annotate RiskService.Risks with {
  title  @title: 'Title';
  prio   @title: 'Priority';
  descr  @title: 'Description';
  miti   @title: 'Mitigation';
  impact @title: 'Impact';
}

annotate RiskService.Mitigations with {
  ID          @(
    UI.Hidden,
    Common: {Text: description}
  );
  description @title: 'Description';
  owner       @title: 'Owner';
  timeline    @title: 'Timeline';
  risks       @title: 'Risks';
}

annotate RiskService.Equipments with {
  name  @title: 'Name';
  descr @title: 'Description';
}

annotate RiskService.Risks with @(UI: {
  HeaderInfo      : {
    TypeName      : 'Risk',
    TypeNamePlural: 'Risks',
    Title         : {
      $Type: 'UI.DataField',
      Value: title
    },
    Description   : {
      $Type: 'UI.DataField',
      Value: descr
    }
  },
  SelectionFields : [prio],
  LineItem        : [
    {Value: title},
    {Value: miti_ID},
    {
      Value      : prio,
      Criticality: criticality
    },
    {
      Value      : impact,
      Criticality: criticality
    },
    {Value: descr}
  ],
  Facets          : [{
    $Type : 'UI.ReferenceFacet',
    Label : 'Main',
    Target: '@UI.FieldGroup#Main'
  }],
  FieldGroup #Main: {Data: [
    {Value: miti_ID},
    {
      Value      : prio,
      Criticality: criticality
    },
    {
      Value      : impact,
      Criticality: criticality
    }
  ]}
}, );

annotate RiskService.Equipments with @(
  UI              : {
    HeaderInfo: {
      TypeName      : 'Equipment',
      TypeNamePlural: 'Equipments',
      Title         : {
        $Type: 'UI.DataField',
        Value: name
      },
      Description   : {
        $Type: 'UI.DataField',
        Value: descr
      }
    },
    LineItem  : [
      {Value: name},
      {Value: descr}
    ]
  },
  Facets          : [{
    $Type : 'UI.ReferenceFacet',
    Label : 'Main',
    Target: '@UI.FieldGroup#Main'
  }],
  FieldGroup #Main: {Data: [
    {Value: name},
    {Value: descr}
  ]}
) {

};

annotate RiskService.Risks with {
  miti @(Common: {
    //show text, not id for mitigation in the context of risks
    Text           : miti.description,
    TextArrangement: #TextOnly,
    ValueList      : {
      Label         : 'Mitigations',
      CollectionPath: 'Mitigations',
      Parameters    : [
        {
          $Type            : 'Common.ValueListParameterInOut',
          LocalDataProperty: miti_ID,
          ValueListProperty: 'ID'
        },
        {
          $Type            : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty: 'description'
        }
      ]
    }
  });
}
