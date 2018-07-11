"use strict";
const path = require("path");
const assert = require("yeoman-assert");
const helpers = require("yeoman-test");

describe("generator-mytest:app", () => {
  beforeAll(() => {
    return helpers
      .run(path.join(__dirname, "../generators/app"))
      .withOptions({ someOption: true })
      .withPrompts({ someAnswer: true });
  });

  it("creates files", () => {
    assert.file(["manage.py", "Pipfile"]);
  });
});
