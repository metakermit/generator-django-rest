"use strict";
const path = require("path");
const assert = require("yeoman-assert");
const helpers = require("yeoman-test");

const util = require('util');
const exec = util.promisify(require('child_process').exec);


function run_partial(cwd) {
  return function(cmd) {
    return exec(cmd, {cwd})
  }
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
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

  describe("docker", () => {
    jest.setTimeout(1000 * 60 * 15) //15 minutes
    afterAll(() => {
      let run = run_partial(rc.targetDirectory)
      return run('docker-compose rm -f -s').catch(() => {})
    });

    it("can build docker container and test", () => {
      let run = run_partial(rc.targetDirectory)
      return run('docker-compose build').then( () => {
        return run('docker-compose up -d')
      }).then( () => {
        return sleep(3000)
      }).then( () => {
        return run('docker-compose run cli test')
      });
    });
  });
});
