class Survey {
  String? id;
  String? type;
  List<Steps>? steps;

  Survey({this.id, this.type, this.steps});

  Survey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Steps {
  StepIdentifier? stepIdentifier;
  String? type;
  String? title;
  String? text;
  AnswerFormat? answerFormat;

  Steps(
      {this.stepIdentifier,
        this.type,
        this.title,
        this.text,
        this.answerFormat});

  Steps.fromJson(Map<String, dynamic> json) {
    stepIdentifier = json['stepIdentifier'] != null
        ? new StepIdentifier.fromJson(json['stepIdentifier'])
        : null;
    type = json['type'];
    title = json['title'];
    text = json['text'];
    answerFormat = json['answerFormat'] != null
        ? new AnswerFormat.fromJson(json['answerFormat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stepIdentifier != null) {
      data['stepIdentifier'] = this.stepIdentifier!.toJson();
    }
    data['type'] = this.type;
    data['title'] = this.title;
    data['text'] = this.text;
    if (this.answerFormat != null) {
      data['answerFormat'] = this.answerFormat!.toJson();
    }
    return data;
  }
}

class StepIdentifier {
  String? id;

  StepIdentifier({this.id});

  StepIdentifier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class AnswerFormat {
  String? type;
  String? positiveAnswer;
  String? negativeAnswer;
  String? result;

  AnswerFormat(
      {this.type, this.positiveAnswer, this.negativeAnswer, this.result});

  AnswerFormat.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    positiveAnswer = json['positiveAnswer'];
    negativeAnswer = json['negativeAnswer'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['positiveAnswer'] = this.positiveAnswer;
    data['negativeAnswer'] = this.negativeAnswer;
    data['result'] = this.result;
    return data;
  }
}