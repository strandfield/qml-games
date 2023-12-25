import QtQml 2.15

QtObject {

    readonly property int length: 4

    property int a: -1
    property int b: -1
    property int c: -1
    property int d: -1

    function equals(other) {
        return length === other.length
        && a === other.a
        && b === other.b
        && c === other.c
        && d === other.d
    }

    function setColor(i, thecolor) {
        if (i < 0 || i >= length) return;

        if (i === 0) {
            a = thecolor;
        } else if (i === 1) {
            b = thecolor;
        } else if (i === 2) {
            c = thecolor;
        } else if (i === 3) {
            d = thecolor;
        }
    }

    function clearColor(i) {
        setColor(i, -1);
    }

    function clear() {
        for(let i = 0; i < length; ++i) {
            clearColor(i);
        }
    }

    function toArray() {
        return [a, b, c, d];
    }

    function isComplete() {
        let is_it = toArray().every(e => (e !== -1));
        return is_it;
    }

    property bool complete: isComplete()

    function isEmpty() {
        let is_it = toArray().every(e => (e === -1));
        return is_it;
    }

    property bool empty: isEmpty()
}
