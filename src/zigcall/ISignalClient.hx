package zigcall;

/**
    Interface for users to connect and disconnect slots to a signal.
**/
interface ISignalClient<F> {
    public function connect(callback:F):ConnectionToken;
    public function disconnect(callback:F):Void;
    public function isConnected(callback:F):Bool;
}
