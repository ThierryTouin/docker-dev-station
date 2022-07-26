const {STRINGS} = require('./constants');
const {BLANK, CLRF, SEPARATOR} = STRINGS;
const DOUBLE_CLRF = CLRF + CLRF;

/**
 *
 * @param {Object} headersObject
 */
module.exports = function displayHeaders(headersObject) {


    console.log("execute : displayHeaders()");

    for (const key of Object.keys(headersObject)) {
        const value = headersObject[key];
        console.log(key + SEPARATOR + BLANK + value + CLRF);
    }

};
