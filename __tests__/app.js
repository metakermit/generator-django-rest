"use strict";
const path = require("path");
const assert = require("yeoman-assert");
const helpers = require("yeoman-test");

const util = require('util');
const exec = util.promisify(require('child_process').exec);

function run(cmd, options) {
  return exec(cmd, options).then( (stdout, stderr) => {
    if (stderr) assert.fail(stderr)
    return stdout
  })
}


describe("generator-mytest:app", () => {
  let rc;
  beforeAll(() => {
    rc = helpers
      .run(path.join(__dirname, "../generators/app"))
      .withOptions({ someOption: true })
      .withPrompts({ someAnswer: true });
    return rc
  });

  it("creates files", () => {
    assert.file(["manage.py", "Pipfile", "docker-compose.yml"]);
  });

  it("can build docker container and test", (cb) => {
    jest.setTimeout(1000 * 60 * 15) //15 minutes
    let dir = rc.targetDirectory
    //return rc.inTmpDir(function (dir) {
      return run('docker-compose build', {cwd: dir}).then( () => {
        return run('docker-compose run cli test', {cwd: dir})
      }).then(cb).catch(error => {
        assert.fail(error)
      });
    //});
  });
});
