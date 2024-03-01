class Exec < Process
  VERSION = "0.1.0"

  def self.run(command : String, args = nil, env : Env = nil, clear_env : Bool = false, shell : Bool = true,
               input : Stdio = Redirect::Inherit, output : Stdio = Redirect::Inherit, error : Stdio = Redirect::Inherit, chdir : Path | String? = nil) : Process::Status
    status = new(command, args, env, clear_env, shell, input, output, error, chdir).wait
    $? = status
    status
  end

  def self.code(command : String, args = nil, env : Env = nil, clear_env : Bool = false, shell : Bool = true,
                input : Stdio = Redirect::Inherit, output : Stdio = Redirect::Inherit, error : Stdio = Redirect::Inherit, chdir : Path | String? = nil) : Int32
    status = new(command, args, env, clear_env, shell, input, output, error, chdir).wait
    $? = status
    status.exit_code
  rescue File::NotFoundError
    127
  end

  def self.output(command) : String
    process = new(command, shell: true, input: Redirect::Inherit, output: Redirect::Pipe, error: Redirect::Inherit)
    output = process.output.gets_to_end
    status = process.wait
    $? = status
    output.chomp
  end

  def self.each_line(command, chomp = false, &block : String ->) : Nil
    process = new(command, shell: true, input: Redirect::Inherit, output: Redirect::Pipe, error: Redirect::Inherit)
    output = process.output.gets_to_end
    status = process.wait
    $? = status
    output.each_line(chomp) do |line|
      yield line
    end
  end

  def self.each_line(command, chomp = false)
    process = new(command, shell: true, input: Redirect::Inherit, output: Redirect::Pipe, error: Redirect::Inherit)
    output = process.output.gets_to_end
    status = process.wait
    $? = status
    output.each_line(chomp).to_a
  end
end
