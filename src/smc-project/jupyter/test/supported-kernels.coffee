###
Do one simple test with each of the kernel we test the cocalc
Jupyter client with.
###

expect  = require('expect')

common = require('./common')

{output} = common

describe 'compute 4/3 using the python2 kernel -- ', ->
    @timeout(5000)

    kernel = undefined
    it 'evaluate 4/3', (done) ->
        kernel = common.kernel('python2')
        kernel.execute_code
            code : '4/3'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    expect(output(v)).toEqual({"text/plain":"1"})
                    done()

    it 'closes the kernel', ->
        kernel.close()

describe 'test the bash kernel --', ->
    @timeout(5000)
    kernel = undefined

    it 'pwd', (done) ->
        kernel = common.kernel('bash')
        kernel.execute_code
            code : 'cd /tmp; pwd'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    o = output(v)
                    expect(o.slice(o.length-9)).toBe('tmp\n')
                    done()

    it 'stateful setting of env sets', (done) ->
        kernel.execute_code
            code : "export FOOBAR='cocalc'; export FOOBAR2='cocalc2'; echo 'done'"
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    o = output(v)
                    expect(o).toBe('done\n')
                    done()

    it 'stateful setting of env worked', (done) ->
        kernel.execute_code
            code : "echo $FOOBAR; echo $FOOBAR2"
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    o = output(v)
                    expect(o).toBe('cocalc\ncocalc2\n')
                    done()

    it 'closes the kernel', ->
        kernel.close()


describe 'test the python3 kernel --', ->
    @timeout(10000)

    kernel = undefined
    it 'evaluate 4/3', (done) ->
        kernel = common.kernel('python3')
        kernel.execute_code
            code : '4/3'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    expect(output(v)).toEqual({"text/plain":"1.3333333333333333"})
                    done()

    it 'closes the kernel', ->
        kernel.close()

describe 'test the sage kernel --', ->
    @timeout(30000)

    kernel = undefined
    it 'evaluate 4/3', (done) ->
        kernel = common.kernel('sagemath')
        kernel.execute_code
            code : '4/3'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    expect(output(v)).toEqual({"text/plain":"4/3"})
                    done()

    it 'closes the kernel', ->
        kernel.close()

describe 'test the octave kernel --', ->
    @timeout(10000)
    kernel = undefined
    it 'evaluate 4/3', (done) ->
        kernel = common.kernel('octave')
        kernel.execute_code
            code : '4/3'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    expect(output(v)).toEqual('ans =  1.3333\n' )
                    done()

    it 'closes the kernel', ->
        kernel.close()


describe 'test the julia kernel --', ->
    @timeout(20000)
    kernel = undefined
    it 'evaluate 4/3', (done) ->
        kernel = common.kernel('julia')
        kernel.execute_code
            code : '4/3'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    expect(output(v)).toEqual({ 'text/plain': '1.3333333333333333' })
                    done()

    it 'closes the kernel', ->
        kernel.close()


describe 'test the non-sage R kernel --', ->
    @timeout(5000)
    kernel = undefined
    it 'evaluate sd(c(1,2,5))', (done) ->
        kernel = common.kernel('ir')
        kernel.execute_code
            code : 'sd(c(1,2,5))'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    expect(output(v)).toEqual({ 'text/html': '2.08166599946613', 'text/latex': '2.08166599946613', 'text/markdown': '2.08166599946613', 'text/plain': '[1] 2.081666' })
                    done()

    it 'closes the kernel', ->
        kernel.close()

describe 'test the sage R kernel --', ->
    @timeout(5000)
    kernel = undefined
    it 'evaluate sd(c(1,2,5))', (done) ->
        kernel = common.kernel('ir-sage')
        kernel.execute_code
            code : 'sd(c(1,2,5))'
            all  : true
            cb   : (err, v) ->
                if err
                    done(err)
                else
                    expect(output(v)).toEqual({ 'text/html': '2.08166599946613', 'text/latex': '2.08166599946613', 'text/markdown': '2.08166599946613', 'text/plain': '[1] 2.081666' })
                    done()

    it 'closes the kernel', ->
        kernel.close()





