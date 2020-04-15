

void parse () {
  JSONObject json = loadJSONObject("data.json");
  parseEntities (json.getJSONArray("entities"));
  parseAssociations (json.getJSONArray("associations"));
  parsePlaceHolder (json.getJSONArray("placeHolders"));
  parseLink (json.getJSONArray("links"));
}

void parseEntities (final JSONArray array) {
  if (array == null) return;
  for (int i = 0; i < array.size(); i++) {
    JSONObject entity = array.getJSONObject(i);
    positions.put(entity.getString("name"), new Entity(
      entity.getString("name"),
      entity.get("px") instanceof Integer ? entity.getFloat("px") : parseExpression (entity.getString("px")),
      entity.get("py") instanceof Integer ? entity.getFloat("py") : parseExpression (entity.getString("py")),
      positions.get(entity.isNull("relativeTo") ? "TL" : entity.getString("relativeTo"))
    ));
    parseAttribute (entity.getJSONArray("attributes"), positions.get(entity.getString("name")));
  }
}
void parseAttribute (final JSONArray array, final Positioned parent) {
  if (array == null) return;
  int[] count = new int[]{0, 0, 0, 0}; // left, top, right, bottom
  for (int i = 0; i < array.size(); i++) {
    JSONObject entity = array.getJSONObject(i);
    int parentPosition = getDirection(entity.getString("relativeToPosition"));
    int pos = -1;
    if (parentPosition == LEFT) pos = count[0]++;
    else if (parentPosition == TOP) pos = count[1]++;
    else if (parentPosition == RIGHT) pos = count[2]++;
    else if (parentPosition == BOTTOM) pos = count[3]++;
    if (pos >= 0) entity.setInt("pos", pos);
  }
  for (int i = 0; i < array.size(); i++) {
    JSONObject entity = array.getJSONObject(i);
    String label = entity.getString("labelPosition");
    int parentPosition = getDirection(entity.getString("relativeToPosition"));
    float x, y;
    float padding = entity.isNull("padding") ? 30 : entity.getFloat("padding");
    if (parentPosition == LEFT) {
      x = -kWIDTH/2-padding;
      y = 30*entity.getInt("pos") + 15 - 15*count[0];
    } else if (parentPosition == RIGHT) {
      x = kWIDTH/2+padding;
      y = 30*entity.getInt("pos") + 15 - 15*count[2];
    } else if (parentPosition == TOP) {
      x = 30*entity.getInt("pos") + 15 - 15*count[1];
      y = -kHEIGHT/2-padding;
    } else if (parentPosition == BOTTOM) {
      x = 30*entity.getInt("pos") + 15 - 15*count[3];
      y = kHEIGHT/2+padding;
    } else {
      x = parseExpression(entity.getString("relativeToPosition").split(",")[0].trim());
      y = parseExpression(entity.getString("relativeToPosition").split(",")[1].trim());
    }
    if (label == null || label.isEmpty()) positions.put(entity.getString("name"), new Dot(x, y, entity.isNull("primary") ? false : entity.getBoolean("primary"), parent));
    else positions.put(entity.getString("name"), new Attribute(
      entity.getString("name"),
      getDirection(label),
      x,
      y,
      entity.isNull("primary") ? false : entity.getBoolean("primary"),
      parent
    ));
    if (entity.isNull("linearLink"))
      links.add(new Link(parent, positions.get(entity.getString("name")), true));
    else if (!entity.getString("linearLink").equals("x"))
      links.add(new Link(parent, positions.get(entity.getString("name")), entity.getString("linearLink").equals("|") ? Direction.VERTICAL : Direction.HORIZONTAL));
  }
}
void parseAssociations (final JSONArray array) {
  if (array == null) return;
  for (int i = 0; i < array.size(); i++) {
    JSONObject association = array.getJSONObject(i);
    positions.put(association.getString("name"), new Association(
      association.getString("name"),
      association.get("px") instanceof Integer ? association.getFloat("px") : parseExpression (association.getString("px")),
      association.get("py") instanceof Integer ? association.getFloat("py") : parseExpression (association.getString("py")),
      positions.get(association.isNull("relativeTo") ? "TL" : association.getString("relativeTo"))
    ));
    parseAttribute (association.getJSONArray("attributes"), positions.get(association.getString("name")));
    final JSONArray entities = association.getJSONArray("entities");
    if (entities == null) continue;
    for (int j = 0; j < entities.size(); j++) {
      JSONObject entity = entities.getJSONObject(j);
      final Direction direction = entity.getString("position").equals("^") || entity.getString("position").equals("v") ? Direction.VERTICAL : Direction.HORIZONTAL;
      links.add(new Link (positions.get(association.getString("name")), positions.get(entity.getString("entity")), direction));
      positions.put(entity.getString("entity")+"_"+association.getString("name"), new Cardinality(
        entity.getString("min")+", "+entity.getString("max"),
        getDirection(entity.getString("position")),
        (Association) positions.get(association.getString("name"))
      ));
    }
  }
}
void parsePlaceHolder (final JSONArray array) {
  if (array == null) return;
  for (int i = 0; i < array.size(); i++) {
    JSONObject placeHolder = array.getJSONObject(i);
    positions.put(placeHolder.getString("name"), new Positioned(
      placeHolder.get("px") instanceof Integer ? placeHolder.getFloat("px") : parseExpression (placeHolder.getString("px")),
      placeHolder.get("py") instanceof Integer ? placeHolder.getFloat("py") : parseExpression (placeHolder.getString("py")),
      positions.get(placeHolder.isNull("relativeTo") ? "TL" : placeHolder.getString("relativeTo"))
    ));
  }
}
void parseLink (final JSONArray array) {
  if (array == null) return;
  for (int i = 0; i < array.size(); i++) {
    JSONObject link = array.getJSONObject(i);
    if (link.isNull("defaultDirection"))
      links.add(new Link(
        positions.get(link.getString("from")),
        positions.get(link.getString("to"))
      ));
    else if (link.getString("defaultDirection").equals("/"))
      links.add(new Link(
        positions.get(link.getString("from")),
        positions.get(link.getString("to")),
        true
      ));
    else links.add(new Link(
        positions.get(link.getString("from")),
        positions.get(link.getString("to")),
        link.getString("defaultDirection").equals("-") ? Direction.HORIZONTAL : Direction.VERTICAL
      ));
  }
}

int getDirection (String dir) {
  switch (dir) {
    case "<": return LEFT;
    case "^": return TOP;
    case ">": return RIGHT;
    case "v": return BOTTOM;
    default: return CENTER;
  }
}


// solo espressioni elementari
float parseExpression (String expression) {
  float value = Float.NaN;
  if (expression.contains("+")) {
    value = 0;
    for (String subExpression : expression.split("\\+")) value += parseExpression(subExpression);
  } else if (expression.contains("-")) {
    String[] subExpressions = expression.split("-");
    value = parseExpression(subExpressions[0]);
    for (int i = 1; i < subExpressions.length; i++) value -= parseExpression(subExpressions[i]);
  } else if (expression.contains("*")) {
    value = 1;
    for (String subExpression : expression.split("\\*")) value *= parseExpression(subExpression);
  } else if (expression.contains("/")) {
    String[] subExpressions = expression.split("/");
    value = parseExpression(subExpressions[0]);
    for (int i = 1; i < subExpressions.length; i++) value /= parseExpression(subExpressions[i]);
  } else if (expression.equals("w")) value = kWIDTH;
  else if (expression.equals("h")) value = kHEIGHT;
  else if (expression.equals("W")) value = BR.x-TL.x;
  else if (expression.equals("H")) value = BR.y-TL.y;
  else if (expression.isEmpty()) value = 0;
  else value = Float.parseFloat(expression);
  return value;
}
